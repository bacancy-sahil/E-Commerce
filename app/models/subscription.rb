class Subscription < ApplicationRecord
    has_many :brands ,dependent: :destroy
end
