Rails.application.routes.draw do
  get '/' => "home#top"

  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  
  
  
end
