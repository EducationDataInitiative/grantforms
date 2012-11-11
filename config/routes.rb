Grants::Application.routes.draw do
  resources :grants, :only => [:index, :show] do
    resources :applications, :only => [:new, :create, :update], :controller => :grant_applications do
      get "contact_info" => "grant_applications#contact_info"
      get "page_1" => "grant_applications#page_1"
      get "page_2" => "grant_applications#page_2"
      get "page_3" => "grant_applications#page_3"
      get "review" => "grant_applications#review"
      post "finish" => "grant_applications#finish"
    end
  end
  resources :applications, :only => :index, :controller => :grant_applications
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do
    get 'sign_up', :to => 'devise/registrations#new', :as => :sign_up
    get 'sign_in', :to => 'devise/sessions#new', :as => :sign_in
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :sign_out
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  resources :organizations

  # Need a root path
  root :to => "grants#index"
end
