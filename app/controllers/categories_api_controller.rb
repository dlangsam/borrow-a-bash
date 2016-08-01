class CategoriesApiController < ApplicationController
	def show		
		distance = params[:miles].to_f
		lat = params[:lat].to_f
		lng = params[:lng].to_f
		search_term = params[:search]

		zip_code = params[:zip]
		if zip_code != nil
			coords = Geocoder.search(zip_code).first.coordinates
			lat = coords[0]
			lng = coords[1]
		end
		if  lat != nil && lng != nil
		 	if current_user
		 		puts "here1"
		 		items = current_user.nearby_items_by_cat(params[:id].to_i, [lat, lng], search_term, distance)
			else
				puts "here2"
				items = User.nearby_items_by_cat(params[:id].to_i, [lat, lng],search_term, distance)
			end
		 else
		 	if current_user 
		 		puts "here3"
		 		items = current_user.nearby_items_by_cat(params[:id].to_i, nil, search_term, distance)
			else
		 		#fix me, need to call search term to
		 		items = Category.find(params[:id]).items
			 end
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
		end		
	end
end
