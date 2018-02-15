Rails.application.routes.draw do


  get 'img/edit'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  
  root 'home#index'
  resources :posts
 
  get "posts/:id/new_tweet" => "posts#new_tweet"
  get "posts/:id/create_tweet" => "posts#create_tweet"
  get "users/:id" => "users#show"
  get 'share_users/new'

  
  

  
  post "imgs/:id/update" => "imgs#update"
  post "imgs/:id/destroy" => "imgs#destroy"
  resources :profiles

  get "auth/:provider/callback" => "share_users#new"
end