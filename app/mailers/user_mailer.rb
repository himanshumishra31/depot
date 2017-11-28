class UserMailer < ApplicationMailer
  default from: Rails.application.secrets.username
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.created.subject
  #

  def self.created(user)
    @user = user
    ActionMailer::Base.mail(from: Rails.application.secrets.username, to: @user.email, subject: 'Pragmatic Store', body: "Welcome").deliver
  end
end
