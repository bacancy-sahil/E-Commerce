# frozen_string_literal: true

# city
class City < ApplicationRecord
  has_many :areas, dependent: :destroy
  belongs_to :state
end
