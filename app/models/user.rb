# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets
  validates_presence_of :email, :name, :time_zone
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def prefered_time
    # getting the prefered time of the day that the user wants to recieve
    # notification for today.
    Time.current.in_time_zone(time_zone)
        .change(hour: due_date_reminder_time.hour,
                min: due_date_reminder_time.min)
  end
end
