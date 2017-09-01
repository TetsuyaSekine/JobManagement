Rails.application.routes.draw do

  resources :tasks
  resources :shains
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/ankens', to: 'ankens#index'
  post '/ankens/search', to: 'ankens#index'
  get '/ankens/new', to: 'ankens#new'
  get '/ankens/:id', to: 'ankens#show', as: 'anken'
  get '/ankens/:id/edit', to: 'ankens#edit', as: 'ankens_edit'
  post '/ankens', to: 'ankens#create'
  patch '/ankens/:id', to: 'ankens#update'
  put '/ankens/:id', to: 'ankens#update'
  delete '/ankens/:id', to: 'ankens#destroy'

  get '/ankens/comments/:id', to: 'ankens#comment_show', as: 'comment'
  get '/ankens/comments/:anken_id/new', to: 'ankens#comment', as: 'comments'
  post '/ankens/comments/:id/new', to: 'ankens#comment_create'
  get '/ankens/comments/:anken_id/:id/edit', to: 'ankens#comment_edit', as: 'comments_edit'
  post '/ankens/comments/:id/update', to: 'ankens#comment_update'
  patch '/ankens/comments/:id', to: 'ankens#comment_update'
  delete '/ankens/comments/:id', to: 'ankens#comment_destroy'

  get '/customers', to: 'customers#index'
  get '/customers/new', to: 'customers#new'
  get '/customers/:id', to: 'customers#show', as: 'customer'
  get '/customers/:id/edit', to: 'customers#edit', as: 'customers_edit'
  post '/customers', to: 'customers#create'
  patch '/customers/:id', to: 'customers#update'
  put '/customers/:id', to: 'customers#update'
  delete '/customers/:id', to: 'customers#destroy'

  get '/tantos', to: 'tantos#index'
  get '/tantos/new', to: 'tantos#new'
  get '/tantos/:id', to: 'tantos#show', as: 'tanto'
  get '/tantos/:id/edit', to: 'tantos#edit', as: 'tantos_edit'
  post '/tantos', to: 'tantos#create'
  patch '/tantos/:id', to: 'tantos#update'
  put '/tantos/:id', to: 'tantos#update'
  delete '/tantos/:id', to: 'tantos#destroy'

  get '/code_msts', to: 'code_msts#index'
  get '/code_msts/new', to: 'code_msts#new'
  get '/code_msts/:id', to: 'code_msts#show', as: 'code_mst'
  get '/code_msts/:id/edit', to: 'code_msts#edit', as: 'code_msts_edit'
  post '/code_msts', to: 'code_msts#create'
  patch '/code_msts/:id', to: 'code_msts#update'
  put '/code_msts/:id', to: 'code_msts#update'
  delete '/code_msts/:id', to: 'code_msts#destroy'

  devise_for :users
  devise_scope :user do
      root :to => "devise/sessions#new"
  end
end
