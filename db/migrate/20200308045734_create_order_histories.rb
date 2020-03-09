class CreateOrderHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_histories do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :quentity
      t.timestamps
    end
  end
end
