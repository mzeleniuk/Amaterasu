class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :set_i18n_locale_from_params
  before_filter :signed_in_user

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: t(:login)
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = t('errors.access_denied')
      redirect_to root_url
    end
  end

  protected

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
