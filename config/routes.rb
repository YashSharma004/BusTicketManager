Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  root to: "home#index"
  resources :payments
  get 'home/index'
  resources :tickets
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
