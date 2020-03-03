class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if (current_user.has_role?(:brand))
      brands_path
    elsif (current_user.has_role?(:admin))
      categories_path
    else (current_user.has_role?(:user))  
      user1s_home_path
    end
  end
  
end
