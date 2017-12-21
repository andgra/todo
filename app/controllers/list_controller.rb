class ListController < ApplicationController
  before_action :authenticate_user!
  def index
    @lists = current_user.lists
  end

  def ajax
    type = params[:type]
    ret = {'code': 0, 'text': 'неизвестный тип запроса'}
    case type
      when 'edit'
        id = params[:list_id]
        title = params[:title]
        list = List.find(id)
        list.title = title
        list.save
        ret[:code] = 1
        render json: ret
      when 'del'
        id = params[:list_id]
        list = List.find(id)
        list.destroy
        ret[:code] = 1
        render json: ret
      when 'add'
        title = params[:title]
        list = List.create(title: title)
        ret[:code] = 1
        ret[:text] = list.id
        render json: ret
      else
        render json: ret
    end
  end
end
