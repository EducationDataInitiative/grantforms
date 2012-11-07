Grants::Application.routes.draw do
  resources :grants, :only => [:index, :show]
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Need a root path
  root :to => "grants#index"
end
