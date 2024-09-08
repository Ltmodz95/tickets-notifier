# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, dependent: :destroy
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  validates_presence_of :time_zone, :due_date_reminder_time, :due_date_reminder_interval, if: :send_due_date_reminder?
  scope :due_date_reminder_active, -> { where(send_due_date_reminder: true) }

  def preferred_time
    # getting the prefered time of the day that the user wants to recieve
    # notification for today.
    Time.current.in_time_zone(time_zone)
        .change(hour: due_date_reminder_time.hour,
                min: due_date_reminder_time.min)
  end

  def preferred_communication
    # lets assume this reads from a table that has the user's preferences
    # on how we should send them a notification for example: Email,SMS,Push
    # but for the sake of the task and the time we will assume that the user
    # is prefering an email communication
    'email'
  end
end
