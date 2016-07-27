class StaticController < ApplicationController
	def index
	end
	def nearby
		@nearby_items = current_user.nearby_items
	end
end
