# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :email, :name
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
