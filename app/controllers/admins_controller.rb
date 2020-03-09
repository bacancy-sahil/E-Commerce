# frozen_string_literal: true

# AdminContoller.
class AdminsController < ApplicationController
  def index
    @category = Category.all
  end
end
