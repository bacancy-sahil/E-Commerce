# frozen_string_literal: true

# SubCategory
class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products
  validates :name, uniqueness: true, length: { in: 2..25 }
  # scope :check_status_of_subcategory, -> { where(status: true) }
end
