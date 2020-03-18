# frozen_string_literal: true

class NewsLetterMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.news_letter_mailer.sendmail.subject
  #
  def sendmail(user, subject, text)
    @user = user
    @greeting = text
    mail to: @user.email, subject: subject
  end

  def sendCongratulations(brand)
    name = brand.name
    @greeting = "hii #{name}, Now your become a brand and your subscription is start now."
    mail to: brand.user.email, subject: 'congratulations'
  end

  # def order(cart)
  #   binding.pry
  #   @cart = cart
  #   binding.pry
  #   mail to: cart.user.email, subject: "Your Orders"
  # end

  def sendDelete(brand)
    name = brand.name
    @greeting = "hii #{name},Your account is deleted by admin."
    mail to: brand.user.email, subject: 'Delete Brand'
  end
end
