Rails.application.routes.draw do
  get 'make_my_trip_bookings/new'
  get 'make_my_trip_bookings/search', to: 'make_my_trip_bookings#search', as: :search_buses
  get 'make_my_trip_bookings/search_suggestion'
  get 'ticket_bookings/new'
  get 'ticket_bookings/create'
  devise_for :users
  ActiveAdmin.routes(self)
  root to: "home#index"
  resources :payments
  get 'home/index'
  resources :tickets do
    resources :ticket_bookings, only: [:new, :create]
  end
  resources :users do
    get 'my_tickets', on: :collection
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
