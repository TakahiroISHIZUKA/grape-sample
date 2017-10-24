Rails.application.routes.draw do
  root to: "blogs#index"
  devise_for :users
  resources :blogs
  resources :users
  
  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/docs'
end
