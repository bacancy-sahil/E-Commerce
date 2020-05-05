# frozen_string_literal: true

# ApplicationContoller.
class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    if current_user.has_role?(:brand)
      brands_path
    elsif current_user.has_role?(:admin)
      admins_index_path
    elsif current_user.has_role?(:user)
      client_home_path
    end
  end
end
