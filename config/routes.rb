Rails.application.routes.draw do
  root to: "home#top"
  get "home/about" => "home#about", as: "about"
  devise_for :users
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :show, :edit, :index, :destroy, :update, :create]
end
