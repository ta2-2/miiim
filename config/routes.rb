Rails.application.routes.draw do

  devise_for :users
  root 'home#index'
  
  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  
  
  
end
