class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end

    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
