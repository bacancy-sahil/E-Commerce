# frozen_string_literal: true

# ProductHelper
module ProductsHelper
  def product(a)
    Product.where(brand_id: a)
  end
end
