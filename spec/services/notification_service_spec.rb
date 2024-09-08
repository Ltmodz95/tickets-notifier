require 'rails_helper'
RSpec.describe NotificationService, type: :model do
  let(:ticket) { create(:ticket) }
  describe '.new' do
    context 'with a supported notification service' do
      it 'sets klass to the correct notification service' do
        notification_service = described_class.new(ticket.id, 'email')
        expect(notification_service.instance_variable_get(:@klass)).to eql Notifications::EmailNotification
      end
    end

    context 'with a unsupported notification service' do
      it 'raise an error' do
        expect do
          described_class.new(ticket.id, 'sms')
        end.to raise_error(StandardError, 'Notification service not found')
      end
    end
  end

  describe '#call' do
    context 'with the preferred communication being email' do
      it 'notifies' do
        expect_any_instance_of(Notifications::EmailNotification).to receive(:notify)
        described_class.new(ticket.id, 'email').call
      end
    end
  end
end
