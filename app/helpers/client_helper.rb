# frozen_string_literal: true

# AdminsHelper
module ClientHelper
  def product_base_comments(product)
    Comment.where(product_id: product.id)
  end

  def findlike(cm)
    Like.where(comment_id: cm, likeValue: true).count
  end

  def like_exists(cu, cm)
    Like.exists?(user_id: cu, comment_id: cm, likeValue: true)
  end

  def like_exists_false(cu, cm)
    Like.exists?(user_id: cu, comment_id: cm, likeValue: false)
  end

  def cart(p)
    Cart.where(user_id: current_user.id, product_id: p.id)
  end

  def mapping_products
    current_user.mappingtable.product.category.products
  end
end
