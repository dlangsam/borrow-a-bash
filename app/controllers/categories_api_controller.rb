class CategoriesApiController < ApplicationController
	def show
		items = Category.find(params[:id]).items

		distance = params[:miles].to_f
		lat = params[:lat].to_f
		lng = params[:lng].to_f
		
		zip_code = params[:zip]
		if zip_code != nil
			coords = Geocoder.search(zip_code).first.coordinates
			lat = coords[0]
			lng = coords[1]
		end

		##maybe get lat and lng from cookie if still null or current user???


	
		 if  lat != nil && lng != nil
		 		if current_user
		 			puts "Getting items based on logged in user"
 	 				items = current_user.nearby_items_by_cat(params[:id].to_i, [lat, lng], distance)
				else
					items = User.nearby_items_by_cat(params[:id].to_i, [lat, lng], distance)
				end
		 else 
		 		items = Category.find(params[:id]).items
		 		if items
		 			lat = items[1].user.latitude;
		 			lng = items[1].user.longitude;
		 		else
		 			lat = 0
		 			lng = 0
		 		end
		 end
		unless items
			render status: 400, json: {error: "Items not found"}
		else
			render :json => {
			:items => items.as_json(:include => :user),
			:location => {:lat => lat, :lng => lng}
			}
			

   				# render :json => {
      	# 			:items => items{:include => :user},
      	# 			:location => {:lat => lat, :lng => lng}
      	# 		}
   			

		end		
	end
end
