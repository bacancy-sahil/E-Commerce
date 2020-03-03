class SubCategory < ApplicationRecord
    belongs_to :category
    has_many :products
    validates :name ,uniqueness: true,length:{in: 2..25 }

end
