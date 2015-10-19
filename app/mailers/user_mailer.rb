class UserMailer < ActionMailer::Base
  default from: 'noreply@amaterasu.com'

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'Amaterasu - Account activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Amaterasu - Password reset'
  end

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Amaterasu!'
  end
end
