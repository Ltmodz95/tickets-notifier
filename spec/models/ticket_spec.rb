require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket) { build(:ticket) }
  let(:no_title_ticket) { build(:ticket, :with_empty_title) }
  let(:no_description_ticket) { build(:ticket, :with_empty_description) }
  describe '.create' do
    context 'with valid data' do
      it { expect(ticket.valid?).to eql true }
    end

    context 'with invalid data' do
      it do
        no_title_ticket.validate
        expect(no_title_ticket.errors.full_messages.first).to eq "Title can't be blank"
      end

      it do
        no_description_ticket.validate
        expect(no_description_ticket.errors.full_messages.first).to eq "Description can't be blank"
      end
    end
  end
end
