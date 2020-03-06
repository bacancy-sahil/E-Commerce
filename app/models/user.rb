class User < ApplicationRecord
  rolify


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :like
  has_one :comment
  has_one :cart
  has_one :brand
  has_one :mappingtable
  accepts_nested_attributes_for :brand

  after_create :create_account

  def create_account
    @user = User.last
    @user.add_role :user
  end

  
end
