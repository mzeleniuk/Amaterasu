class StaticPagesController < ApplicationController
  skip_before_filter :signed_in_user

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 15)
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
