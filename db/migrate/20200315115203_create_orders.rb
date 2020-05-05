# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :user_id
      t.boolean :status, default: false
      t.integer :quantity
      t.timestamps
    end
  end
end
