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
    @newsletter = Newsletter.all
    @newsletter.each do |news|
      NewsLetterMailer.sendmail(news, params[:subject], params[:message]).deliver_now
    end
  end

  def sendCongo(brand)
    subject = 'hii <%= brand.name %> Now your become a brand and your subscription is start now.'
    text = 'congratulations'
    email = brand.email
    NewsLetterMailer.sendmail(email, subject, text).deliver_now
  end
end
