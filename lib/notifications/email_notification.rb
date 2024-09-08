# frozen_string_literal: true

module Notifications
  # a class that handles the notification by email
  # for the users
  class EmailNotification < Notification
    def self.notify(ticket_id)
      UserMailer.with(ticket_id:).due_date_reminder.deliver_now
      # mark the ticket as has_reminder sent
    end
  end
end
