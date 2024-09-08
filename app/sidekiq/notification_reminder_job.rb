class NotificationReminderJob
  include Sidekiq::Job

  def perform(*_args)
    users = User.includes(:tickets).all

    # keeping track of the current_time so if the email processing took more than a minute we
    # dont miss out on some users
    current_time = Time.current.beginning_of_minute

    users.each do |user|
      # comparing the user's preferred_time to be notified in with the current time
      # to check which users should we send them reminders in this minute
      next unless user.preferred_time == current_time.in_time_zone(user.time_zone)

      notify_due_date_approaching(user, user.tickets)
    end
  end

  private

  def notify_due_date_approaching(user, tickets)
    tickets.each do |ticket|
      # don't notify the user if the task is due before the preferred time where the user would like to receive
      # the notification, it might be out of working hours or at midnight
      next unless ticket.remind_at >= user.preferred_time && ticket.remind_at <= user.preferred_time.end_of_day

      # this service is responsible for just routing the notifications based on the
      # user's preferred communication method for example email,sms
      NotificationService.new(ticket.id, user.preferred_communication).call
    end
  end
end
