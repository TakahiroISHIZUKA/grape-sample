Rails.application.routes.draw do
  resources :blogs
  resources :users
  
  mount API::Base => '/'
  mount GrapeSwaggerRails::Engine => '/docs'
end
