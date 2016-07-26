Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "static/find", to: "static#find_users"

  resources :users do
		resources :items
	end

	scope "/api" do
		resources :users, controller: "users_api" do
			resources :items, controller: "items_api" 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
