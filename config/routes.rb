Rails.application.routes.draw do
  get '/w', to: 'todo#lists'
  get '/w/:id', to: 'todo#tasks'

  devise_for :users

  get 'main/index'
  root 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
