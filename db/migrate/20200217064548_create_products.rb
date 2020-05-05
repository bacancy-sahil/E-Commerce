# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.boolean :status, default: true
      t.integer :price, null: false
      t.text :description, default: ''
      t.integer :quantity, null: false
      t.integer :category_id
      t.integer :sub_category_id
      t.integer :brand_id
      t.timestamps
    end
  end
end
