Rails.application.routes.draw do
  devise_for :users
  root to: "static#index"
  get "/users", to: "static#index"
  get "/items/:id", to: "items#item"
  get "/items/:search_term", to: "items#search"
  get "/items/:id/message/new", to: "items#message"
  get "/messages/outgoing", to: "messages#outbox"
  get "/messages/:id/reply", to:"messages#reply"
  get "/categories(/:id)"       , to: "categories#show", as: "category"

  resources :messages, only: [:index, :show, :new, :create]
  resources :users, only: [] do
		resources :items
		
	end

	scope "/api" do
		patch "/items/:id/remove_image", to: "items_api#remove_image"
		patch "/items/:id/change_activation", to: "items_api#change_published"
		get "/categories", to: "categories_api#show"
		resources :users, controller: "users_api", only: [] do
			resources :items, controller: "items_api" 
		end
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
