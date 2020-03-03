class NewsLettersController < ApplicationController
before_action :authenticate_user!
  def new
    
  end

  def create

    NewsLetterMailer.message.deliver

  end
end
