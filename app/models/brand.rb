# frozen_string_literal: true

# Brand
class Brand < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  scope :check_status_of_brand, -> { where(status: true) }
end
