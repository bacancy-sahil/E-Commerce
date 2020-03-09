class NewsLetterMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.news_letter_mailer.sendmail.subject
  #
  def sendmail(user)
    @user = user
    mail to: @user.email, subject: "Sign up Confirmation."
  end
end
