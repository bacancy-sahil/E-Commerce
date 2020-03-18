# frozen_string_literal: true

# Subscription
class Subscription < ApplicationRecord
  validates :description, presence: true, length: { in: 2..200 }
  validates :price, presence: true, length: { in: 1..4 }
  validates :numberofproducts, presence: true, length: { in: 1..4 }
  validates :duration, presence: true, length: { in: 1..4 }
  has_many :brands, dependent: :destroy
  scope :check_status_of_subscription, -> { where(status: true) }
end
