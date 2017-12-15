class UserMailer < ApplicationMailer
  default from: 'Him <himanshumishra3@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.created.subject
  #

  def self.created(user)
    @user = user
    ActionMailer::Base.mail(from: Rails.application.secrets.username, to: @user.email, subject: 'Pragmatic Store', body: "Welcome").deliver
  end

  def consolidate_mail(user)
    @current_user = user
    I18n.with_locale(user.language) do
      mail to: user.email, subject: t('.subject')
    end
  end
end
