Rails.application.routes.draw do

  devise_for :users
  get 'user_profile/show', to: 'user_profile#show'
  get 'search', to: 'articles#search'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  root to: 'home#index'
  resources :articles
  resources :users
  resources :categories

end
