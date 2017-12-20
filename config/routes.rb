Rails.application.routes.draw do
  get '/lang/:locale', to: 'main#lang', as: 'lang'
  get '/w', to: 'list#index', as: 'lists'
  post '/w/ajax', to: 'list#ajax', as: 'listAjax'
  get '/w/:id', to: 'task#index', as: 'tasks'
  post '/w/:id/ajax', to: 'task#ajax', as: 'taskAjax'

  devise_for :users

  get 'main/index'
  root 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
