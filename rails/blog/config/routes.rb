Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  resources :posts
  resources :comments, only: %i[create destroy edit update]
  resources :likes, only: %i[create destroy]
  resources :user_socials, only: %i[create destroy edit update]
end
