# frozen_string_literal: true

# cart
class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :order
end
