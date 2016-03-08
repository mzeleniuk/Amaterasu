class AccountActivationsController < ApplicationController
  skip_before_filter :signed_in_user

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      sign_in user
      flash[:success] = t(:account_activated)
      redirect_to user

      UserMailer.welcome_email(user).deliver
    else
      flash[:danger] = t(:invalid_activation_link)
      redirect_to root_url
    end
  end
end
