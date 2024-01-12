Rails.application.routes.draw do

  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  get "/users/:id/posts" => "posts#index"
  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  get "/posts" => "posts#index"
  post "/posts" => "posts#create"
  get "/posts/:id" => "posts#show"
  patch "/posts/:id" => "posts#update"
  delete "/posts/:id" => "posts#destroy"

  get "/relationships" => "relationships#index"
  get "/relationships/:id" => "relationships#show"
  post "/relationships" => "relationships#create"
  delete "/relationships/:id" => "relationships#destroy"
end
