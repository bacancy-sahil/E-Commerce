# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def category_status
    Category.where(["status = ?" ,true])
  end

  def find_brand_by_user
    Brand.find_by(user_id:current_user.id) 
  end

  def brand_timing
    (current_user.brand.startingdate..current_user.brand.endingdate).cover?(DateTime.now)
  end
end
