class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :send_due_date_reminder, default: false
      t.integer :due_date_reminder_interval, default: 1
      t.time :due_date_reminder_time
      t.string :time_zone, limit: 50
      t.timestamps
    end
  end
end
