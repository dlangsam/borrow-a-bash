class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		if current_user
			@items = current_user.nearby_items_by_cat(params[:id].to_i)
		else
			lat = cookies[:lat]
			lng = cookies[:lng]
			if  lat != nil && lng != nil
 				@items = User.nearby_items_by_cat(lat, lng, params[:id].to_i)
			else
				@items = Category.find(params[:id]).items
			end
		end
	end
end
