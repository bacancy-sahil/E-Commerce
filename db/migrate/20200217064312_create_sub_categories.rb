# frozen_string_literal: true

class CreateSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_categories do |t|
      t.string :name, null: false
      t.boolean :status, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
