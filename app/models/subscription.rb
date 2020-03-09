# frozen_string_literal: true

# Subscription
class Subscription < ApplicationRecord
  has_many :brands, dependent: :destroy
  scope :check_status_of_subscription, -> { where(status: true) }
end
