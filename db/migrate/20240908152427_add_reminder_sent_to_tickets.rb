class AddReminderSentToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :reminder_sent, :boolean, default: false
  end
end
