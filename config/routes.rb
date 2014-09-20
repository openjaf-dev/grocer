Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/data', as: 'rails_admin'
  root to: 'visitors#index'
  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :user_steps
  resources :organizations
end
