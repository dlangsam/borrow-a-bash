Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "nearby", to: "static#nearby"
  get "/items/:id", to: "items#item"
  resources :categories, only: [:index, :show]

  resources :users, only: [] do
		resources :items, only: [:index, :show, :new, :create]
		resources :messages, only: [:index, :show, :new, :create]
	end

	scope "/api" do
		resources :users, controller: "users_api", only: [] do
			resources :items, controller: "items_api" 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
