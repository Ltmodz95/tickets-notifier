class NotificationReminderJob
  include Sidekiq::Job

  def perform(*_args)
    users = User.includes(:tickets).all
    users.each do |user|
      # this user will not be notified now
      next unless user.preferred_time == Time.current.in_time_zone(user.time_zone).beginning_of_minute

      # get all the tickets that are eligable to be send

      user.tickets.each do |ticket|
        # tickets that should be notified about due date
        if ticket.remind_at >= user.preferred_time && ticket.remind_at <= user.preferred_time.end_of_day
          # send the notification
        end
      end
    end
  end

  private

  def notify_due_date_approaching(tickets)
    tickets.each do |ticket|
      # tickets that should be notified about due date
      if ticket.remind_at >= user.preferred_time && ticket.remind_at <= user.preferred_time.end_of_day
        # send the notification
        user.preferred_communication.Object.get_const
      end
    end
  end
end
