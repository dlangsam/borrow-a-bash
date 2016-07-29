Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "nearby", to: "static#nearby"
  get "/items/:id", to: "items#item"
  get "/items/:id/message/new", to: "items#message"

  resources :categories, only: [:index, :show]
  resources :messages, only: [:index, :show, :new, :create]
  resources :users, only: [] do
		resources :items, only: [:index, :show, :new, :create, :destroy,:update]
		
	end

	scope "/api" do
		patch "/items/:id/change_activation", to: "items_api#show"
		get "categories/:id/:distance", to: "categories_api#show"
		resources :users, controller: "users_api", only: [] do
			resources :items, controller: "items_api" 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
