# frozen_string_literal: true

# Brand
class Brand < ApplicationRecord
  validates :name, presence: true, length: { in: 2..20 }
  validates :subscription, presence: true
  belongs_to :subscription
  belongs_to :user
  scope :check_status_of_brand, -> { where(status: true) }
end
