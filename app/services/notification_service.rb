# frozen_string_literal: true

# A router service that sends the notification to the
# notifier that the user preferes
class NotificationService
  def initialize(ticket_id, preferred_communication)
    notification_service(preferred_communication)
    @ticket_id = ticket_id
  end

  def call
    @klass.new.notify(@ticket_id)
  end

  private

  def notification_service(preferred_communication)
    @klass = Object.const_get("Notifications::#{preferred_communication.camelcase}Notification") # changing the string to the class name
  rescue StandardError
    raise StandardError, 'Notification service not found'
  end
end
