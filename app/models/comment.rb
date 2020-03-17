# frozen_string_literal: true

# comment
class Comment < ApplicationRecord
  has_one :like, dependent: :delete
  belongs_to :product
  belongs_to :user
end
