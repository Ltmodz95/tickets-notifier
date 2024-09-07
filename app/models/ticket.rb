class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: 'User', foreign_key: 'user_id'
  enum :status, %i[to_do in_progress completed]

  validates_presence_of :title, :description
end
