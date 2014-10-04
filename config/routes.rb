Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/data', as: 'rails_admin'
  #root to: 'visitors#index'
  root to: 'rails_admin/main#dashboard'
  
  
  

  
  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :organizations
  resources :organization_steps
  
  get "/organization_step" => "organization_steps#create", :as => :create_organization_step
 
  #post "organization_steps/organization", to: "organization_steps#organization"
  
  #devise_scope :user do
  #  #match '/users/sign_out' => 'sessions#destroy', via: [:get, :delete]
  #  get 'users/sign_out' => "devise/sessions#destroy"
  #end
end
