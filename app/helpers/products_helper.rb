# frozen_string_literal: true

# ProductHelper
module ProductsHelper
  def product(brand_id)
    Product.where(brand_id: brand_id)
  end
end
