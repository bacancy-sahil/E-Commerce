class AddAdminToUser < ActiveRecord::Migration[6.0]
  def change
    
    add_column :users, :firstname, :string 
    add_column :users, :lastname, :string 
    add_column :users, :usertype, :boolean, default: true 
    add_column :users, :gender, :boolean 
    add_column :users, :address, :text 
    add_column :users, :status, :boolean ,default: true
    add_column :users, :phone_number, :bigint
    add_column :users,  :pincode,:integer
  
  end
end
