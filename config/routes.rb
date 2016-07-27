Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "nearby", to: "static#nearby"
  resources :categories, only: [:index, :show]


  resources :users do
		resources :items, only: [:index, :show]
	end

	scope "/api" do
		resources :users, controller: "users_api" do
			resources :items, controller: "items_api" 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
