# frozen_string_literal: true

# state
class State < ApplicationRecord
  has_many :cities, dependent: :destroy
end
