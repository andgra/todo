class MainController < ApplicationController
  def index
    @users = User.all
    ap @users
  end
end
