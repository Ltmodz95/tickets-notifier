# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id'
  enum :status, %i[to_do in_progress completed]

  validates_presence_of :title, :description

  scope :not_completed, -> { where.not(status: 'completed') }
  scope :not_reminded, -> { where(reminder_sent: false) }

  def remind_at
    # calculates the time at which we should remind the user about the task
    due_date.in_time_zone(assignee.time_zone) - assignee.due_date_reminder_interval.days
  end
end
