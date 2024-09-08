# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.belongs_to :user
      t.datetime :due_date
      t.integer :status, default: 0
      t.integer :progress, default: 0
      t.timestamps
    end
  end
end
