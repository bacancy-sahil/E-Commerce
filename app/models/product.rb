class Product < ApplicationRecord
  has_one_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand
  has_one :comment 
  # has_many :products ,dependent: :destroy
  has_one :mappingtable
end
