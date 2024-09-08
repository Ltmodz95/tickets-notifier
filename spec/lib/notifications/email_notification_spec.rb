require 'rails_helper'
RSpec.describe Notifications::EmailNotification, type: :model do
  include ActiveJob::TestHelper
  let(:ticket) { create(:ticket) }
  describe '#notify' do
    it 'enques a due date reminder email' do
      expect do
        described_class.new.notify(ticket.id)
      end.to have_enqueued_mail(UserMailer, :due_date_reminder).once
    end
  end
end
