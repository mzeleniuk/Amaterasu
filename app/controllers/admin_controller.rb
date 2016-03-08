class AdminController < ApplicationController
  before_filter :admin_user

  def index
  end
end
