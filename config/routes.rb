Rails.application.routes.draw do
  get 'firstnames/edit'
  get 'users/show'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "doit/:id/:day/create" => "doit#create"
  post "doit/:id/:day/destroy" => "doit#destroy"


  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"

  get "firstnames/new" => "firstnames#new"
  post "firstnames/:id/create" => "firstnames#create"
  get "firstnames/:id/edit" => "firstnames#edit"
  post "firstnames/:id/destroy" => "firstnames#destroy"
  post "firstnames/:id/update" => "firstnames#update"
  post "firstnames/:id/select" => "firstnames#select"
  get "firstnames/:id/:user/about" => "firstnames#about"




  post "users/create"=> "users#create"
  
  get "signup" => "users#new"
  get "users/:id" => "users#show"

  get "application/month" => "application#month"
  get "posts/index" => "posts#index"
  get"posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"




  get "/" => "home#top"
  get "about" =>"home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
