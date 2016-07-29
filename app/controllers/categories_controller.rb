class CategoriesController < ApplicationController
	def show
		if current_user
			puts current_user.latitude
			puts current_user.longitude
			@items = current_user.nearby_items_by_cat(params[:id].to_i)
		else
			lat = cookies[:lat]
			lng = cookies[:lng]

			if  lat != nil && lng != nil
				puts lat
				puts lng
 				@items = User.nearby_items_by_cat(lat, lng, params[:id].to_i)
			else
				@items = Category.find(params[:id]).items
			end
		end
	end


end
