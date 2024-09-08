require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:bad_email_user) { build(:user, :with_invalid_email) }
  let(:bad_name_user) { build(:user, :with_invalid_name) }

  describe '.create' do
    context 'when creating user with valid data' do
      it 'creates the user successfully' do
        expect(user.valid?).to be true
      end
    end

    context 'when creating user invalid data' do
      it 'responds with error message for invalid email' do
        bad_email_user.validate
        expect(bad_email_user.errors.full_messages.first).to eq 'Email is invalid'
      end

      it 'responds with error message for invalid name' do
        bad_name_user.validate
        expect(bad_name_user.errors.full_messages.first).to eq "Name can't be blank"
      end
    end
  end

  describe '.preferred_time' do
    it 'returns preferred time for reminder notifications' do
      preferred_time = Time.current.in_time_zone(user.time_zone)
                           .change(hour: user.due_date_reminder_time.hour,
                                   min: user.due_date_reminder_time.min)

      expect(user.preferred_time).to eql preferred_time
    end
  end

  describe '.preferred_communication' do
    it 'returns preferred communication for user' do
      expect(user.preferred_communication).to eql 'email'
    end
  end
end
