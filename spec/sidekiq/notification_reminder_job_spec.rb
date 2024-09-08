require 'rails_helper'
RSpec.describe NotificationReminderJob, type: :job do
  # check if how many notification_service calls will be made
  let!(:user) { create(:user, send_due_date_reminder: true) }
  let!(:no_reminder_user) { create(:user) }

  # due date has to be after the preferred time and with the increase of the interval
  let!(:ticket) do
    create(:ticket, assignee: user, due_date: Time.current.change(hour: 17, min: 0) + 1.days)
  end
  let!(:completed_ticket) do
    create(:ticket, assignee: user, status: 'completed', due_date: Time.current.change(hour: 17, min: 0) + 1.days)
  end

  let!(:ticket2) do
    create(:ticket, assignee: no_reminder_user, due_date: Time.current.change(hour: 17, min: 0) + 1.days)
  end

  let!(:out_of_bound_ticket) do
    create(:ticket, assignee: user, due_date: Time.current.change(hour: 17, min: 0))
  end

  let(:job) { described_class.new }

  describe '#perform' do
    context 'user has send due date reminder active' do
      it 'calls EmailNotification' do
        travel_to(user.preferred_time) do
          expect_any_instance_of(Notifications::EmailNotification).to receive(:notify).with(ticket.id)
          job.perform
        end
      end
    end

    context 'user has send due date reminder disabled' do
      it 'dosent call EmailNotification' do
        travel_to(no_reminder_user.preferred_time) do
          expect_any_instance_of(Notifications::EmailNotification).not_to receive(:notify).with(ticket2.id)
          job.perform
        end
      end
    end

    context 'ticket is completed' do
      it 'dosent call EmailNotification' do
        travel_to(user.preferred_time) do
          expect_any_instance_of(Notifications::EmailNotification).not_to receive(:notify).with(completed_ticket.id)
          job.perform
        end
      end
    end

    context 'ticket is out of notification bounds' do
      it 'dosent call EmailNotification' do
        travel_to(user.preferred_time) do
          expect_any_instance_of(Notifications::EmailNotification).not_to receive(:notify).with(out_of_bound_ticket.id)
          job.perform
        end
      end
    end
  end
end
