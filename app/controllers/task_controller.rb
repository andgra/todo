class TaskController < ApplicationController
  before_action :authenticate_user!

  def index
    @list = List.find(params[:id])
    @tasks = @list.tasks
  end

  def ajax
    type = params[:type]
    ret = {'code': 0, 'text': 'неизвестный тип запроса'}
    case type
      when 'edit'
        task_params = params[:task]
        task = Task.find(task_params[:id])
        task.title = task_params[:title]
        task.sort = task_params[:sort]
        task.done = task_params[:done]
        task.save
        ret[:code] = 1
        render json: ret
      when 'del'
        task = Task.find(params[:task_id])
        task.destroy
        ret[:code] = 1
        render json: ret
      when 'add'
        task_params = params[:task]
        task = Task.create(title: task_params[:title], list_id: params[:list_id])
        ret[:code] = 1
        ret[:text] = task.id
        render json: ret
      else
        render json: ret
    end
  end
end
