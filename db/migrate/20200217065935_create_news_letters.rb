class CreateNewsLetters < ActiveRecord::Migration[6.0]
  def change
    create_table :news_letters do |t|
      t.text :email ,null: false
      t.timestamps
    end
  end
end
