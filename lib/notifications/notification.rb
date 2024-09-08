# frozen_string_literal: true

module Notifications
  # An abstract class that enforces the implementation of the notifiy method to
  # all the classes that will be inheriting from
  class Notification
    def self.notify
      raise NoMethodError
    end
  end
end
