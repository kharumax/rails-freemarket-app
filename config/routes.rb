Rails.application.routes.draw do

  root      "top#index"
  get       "signup/",  to: "users#new"
  get       "login/",   to: "sessions#new"
  post      "login/",   to: "sessions#create"
  delete   "logout/",   to: "sessions#destroy"

  resources :users do
    member do
      get 'products'
    end
  end
  resources :account_activations,only: [:edit]
  resources :products
  resources :chat,only: [:create,:show]


end
