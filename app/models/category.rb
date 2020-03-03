class Category < ApplicationRecord
  has_many :SubCategories, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true
end
