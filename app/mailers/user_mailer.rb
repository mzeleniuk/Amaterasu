class UserMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: 'noreply@amaterasu.com'

  def account_activation(user)
    @user = user
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/Logo_dark.png")

    mail to: user.email, subject: 'Amaterasu - Account activation'
  end

  def password_reset(user)
    @user = user
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/Logo_dark.png")

    mail to: user.email, subject: 'Amaterasu - Password reset'
  end

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to Amaterasu!'
  end

  private

  def roadie_options
    super unless Rails.env.test?
  end
end
