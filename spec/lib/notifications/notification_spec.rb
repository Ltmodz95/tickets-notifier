# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Notifications::Notification, type: :model do
  describe '#notify' do
    it 'raises NoMethodError' do
      expect do
        described_class.new.notify
      end.to raise_error
    end
  end
end
