class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.text :description,null: false
      t.integer :price ,null: false
      t.boolean :status ,default: true
      t.integer :numberofproducts ,null: false
      t.integer :duration ,null: false
      t.timestamps
    end
  end
end
