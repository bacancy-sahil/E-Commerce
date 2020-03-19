# frozen_string_literal: true

# BrandHelper
module BrandsHelper
  def brand_subscription
    @brand = Brand.joins(:user).select('users.*, brands.*').where(user_id: current_user.id)
  end
end
