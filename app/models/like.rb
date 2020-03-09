# frozen_string_literal: true

# like
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :comment
end
