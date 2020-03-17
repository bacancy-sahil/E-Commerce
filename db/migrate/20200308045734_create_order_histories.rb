# frozen_string_literal: true

class CreateOrderHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_histories do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :user_id
      t.integer :quentity
      t.timestamps
    end
  end
end
