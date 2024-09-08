# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id'
  enum :status, %i[to_do in_progress completed]

  validates_presence_of :title, :description

  scope :not_completed, -> { where.not(status: 'completed') }
  scope :not_reminded, -> { where(reminder_sent: false) }

  def remind_at
    # getting back the time at which this task should be notified about
    # the date should be something bigger than the prefered_time of the user
    # we bail out on tasks that will finish before the reminder time that is set
    # by the user, for example if the user have tasks that are due by 3 AM
    # and the prefered date is 10 AM then we ignore that notification
    due_date.in_time_zone(assignee.time_zone) - assignee.due_date_reminder_interval.days
  end
end
