# frozen_string_literal: true

class CreatePendingpayments < ActiveRecord::Migration[6.0]
  def change
    create_table :pendingpayments do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :user_id
      t.integer :quantity
      t.timestamps
    end
  end
end
