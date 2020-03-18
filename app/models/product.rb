# frozen_string_literal: true

# product
class Product < ApplicationRecord
  scope :check_status_of_prouct, -> { where(status: true) }
  has_one_attached :image1
  has_one_attached :image2
  has_one_attached :image3
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand
  has_one :comment, dependent: :destroy
  has_one :mappingtable, dependent: :destroy
  scope :search, ->(query) { where(['name LIKE ?', "%#{query}%"]) }
  has_many :orders
end
