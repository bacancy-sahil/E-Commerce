class Comment < ApplicationRecord
    belongs_to :product
    belongs_to :user
    has_one :like
end
