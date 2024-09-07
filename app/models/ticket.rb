class Ticket < ApplicationRecord
  belongs_to :assignee, class_name: 'User', foregin_key_id: 'user_id'
end
