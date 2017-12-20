class MainController < ApplicationController
  def index
    @users = User.all
    ap @users
  end

  def lang
    cookies[:locale] = params[:locale]
    redirect_back(fallback_location: root_path)
  end
end
