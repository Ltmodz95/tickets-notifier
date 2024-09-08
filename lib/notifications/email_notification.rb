# frozen_string_literal: true

module Notifications
  # a class that handles the notification by email
  # for the users
  class EmailNotification < Notification
    def self.notify(ticket_id)
      puts "Sending email for ticket # #{ticket_id}"
    end
  end
end
