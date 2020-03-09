# frozen_string_literal: true

# category
class Category < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  has_many :SubCategories, dependent: :destroy
  has_many :products, dependent: :destroy
  # scope :check_status_of_category, -> { where(status: true) }
end
