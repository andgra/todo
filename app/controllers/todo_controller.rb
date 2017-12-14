class TodoController < ApplicationController
  before_action :authenticate_user!
  def lists
    @lists = List.all
  end
  def tasks
    @list = List.find(params[:id])
    @tasks = @list.tasks
  end
end
