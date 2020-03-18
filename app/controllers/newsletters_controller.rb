# frozen_string_literal: true

class NewslettersController < ApplicationController
  before_action :authenticate_user!, except: [:sendmessage]
  def create
    @newsletter = Newsletter.new
    @newsletter.email = params[:email]
    @newsletter.save 
    render json: {
      data: 'true'
    }
  end

  def sendmessage
    subject = params[:subject]
    text = params[:message]
    @newsletter = Newsletter.all
    for news in @newsletter.each do
      NewsLetterMailer.sendmail(news, subject, text).deliver_now
   end
 end

  def sendCongo(_brand)
    subject = 'hii <%=brand.name%>Now your become a brand and your subscription is start now.'
    text = 'congratulations'
    email = @brand.email
    NewsLetterMailer.sendmail(email, subject, text).deliver_now
  end

  # def order(@cart)
  #   @order = @cart
  #   NewsLetterMailer.order
  # end
end
