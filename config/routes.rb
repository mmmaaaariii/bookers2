Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top", as: "top"
  get "homes/about" => "homes#about", as: "about"
  resources :users, only: [:show, :edit, :index, :update]
  resources :books, only: [:new, :show, :edit, :index, :destroy, :update, :create]
end
