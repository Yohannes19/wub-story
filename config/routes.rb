Rails.application.routes.draw do

  get 'dashboard', to: 'dashboard#index'
  
 # Narrator namespace
 namespace :narrator do
  get 'dashboard', to: 'dashboard#index'
  # Future: narrator-specific features
end

# Listener namespace
namespace :listener do
  get 'dashboard', to: 'dashboard#index'
  resources :dashboard, only: [:index]
  # Future: listener-specific features
end

  resources :stories do
    resources :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    post :transcribe, on: :member
    post :summarize, on: :member
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # Defines the root path route ("/")
  root "pages#home"
end
