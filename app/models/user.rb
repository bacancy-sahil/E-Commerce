# frozen_string_literal: true

# user
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_one :brand, dependent: :destroy
  has_one :mappingtable, dependent: :destroy
  accepts_nested_attributes_for :brand
  after_create :create_account
  def create_account
    @user = User.last
    @user.add_role :user
  end
  has_one :order
  # validates :email, presence: true, length: { in: 2..20 }
  # validates :encrypted_password, presence: true, length: { in: 2..20 }
end
