# frozen_string_literal: true

# AdminsHelper
module AdminsHelper
  def orderHistory
    pie_chart OrderHistory.group(:name).count
  end

  def product_available
    pie_chart Product.pluck(:name, :quentity)
  end

  def user_login
    line_chart User.group('DATE(created_at)').count
  end

  def select_tag_status
    select_tag(:status, options_for_select([['Pendding', 0], ['Approve', 1], ['Delete', 2]]))
  end
end
