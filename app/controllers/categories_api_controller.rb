class CategoriesApiController < ApplicationController
	def show
		distance = params[:distance]
		if current_user
			items = current_user.nearby_items_by_cat(params[:id].to_i, distance)
		else
			lat = cookies[:lat]
			lng = cookies[:lng]
			if  lat != nil && lng != nil
 				items = User.nearby_items_by_cat(lat, lng, params[:id].to_i, distance)
			else
				items = Category.find(params[:id]).items
			end
		end	
		unless items
			render status: 400, json: {error: "Items not found"}
		else
			render json: items
		end		
	end
end
