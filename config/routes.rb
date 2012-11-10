Grants::Application.routes.draw do
  resources :grants, :only => [:index, :show]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do
    get 'sign_up', :to => 'devise/registrations#new', :as => :sign_up
    get 'sign_in', :to => 'devise/sessions#new', :as => :sign_in
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :sign_out
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Need a root path
  root :to => "grants#index"
end
