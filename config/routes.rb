Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "static/find", to: "static#find_users"

  resources :user do
		resources :items
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
