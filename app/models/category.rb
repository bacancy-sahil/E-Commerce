# frozen_string_literal: true

# category
class Category < ApplicationRecord
  validates :name, presence: true, length: { in: 2..20 }
  has_many :SubCategories, dependent: :destroy
  has_many :products, dependent: :destroy
  # scope :check_status_of_category, -> { where(status: true) }
end
