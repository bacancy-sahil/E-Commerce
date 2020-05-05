# frozen_string_literal: true

class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.references :subscription, foreign_key: true
      t.integer :user_id
      t.integer :status, default: 0
      t.datetime :startingdate
      t.datetime :endingdate
      t.timestamps
    end
  end
end
