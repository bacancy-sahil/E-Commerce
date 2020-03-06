class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.references :product
      t.references :user
      t.timestamps
    end
  end
end
