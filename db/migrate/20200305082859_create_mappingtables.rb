# frozen_string_literal: true

class CreateMappingtables < ActiveRecord::Migration[6.0]
  def change
    create_table :mappingtables do |t|
      t.integer :product_id
      t.integer :user_id
      t.timestamps
    end
  end
end
