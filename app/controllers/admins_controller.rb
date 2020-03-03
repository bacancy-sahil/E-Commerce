class AdminsController < ApplicationController
  def index
    @category = Category.all
  end
end
