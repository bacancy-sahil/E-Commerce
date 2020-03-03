class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name ,null: false
      t.boolean :status ,default: true
      t.integer :pincode, null: false
      t.integer :city_id ,null: false
      t.timestamps
    end
  end
end
