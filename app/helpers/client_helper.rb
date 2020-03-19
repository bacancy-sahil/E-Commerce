# frozen_string_literal: true

# AdminsHelper
module ClientHelper
  def product_base_comments(product)
    Comment.where(product_id: product.id)
  end

  def findlike(comment_id)
    Like.where(comment_id: comment_id, likeValue: true).count
  end

  def like_exists(current_user, comment_id)
    Like.exists?(user_id: current_user, comment_id: comment_id, likeValue: true)
  end

  def like_exists_false(current_user, comment_id)
    Like.exists?(user_id: current_user, comment_id: comment_id, likeValue: false)
  end

  def cart(product)
    Cart.where(user_id: current_user.id, product_id: product.id)
  end

  def mapping_products
    current_user.mappingtable.product.category.products
  end
end
