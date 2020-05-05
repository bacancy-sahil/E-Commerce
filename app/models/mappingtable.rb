# frozen_string_literal: true

# mapping
class Mappingtable < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
