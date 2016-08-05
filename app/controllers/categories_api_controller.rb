class CategoriesApiController < ApplicationController
	def show
		category = params[:category]
		if category != ""
		  category = category.to_i
		else 
			category = nil
		end	
		deposit = params[:deposit]
		if deposit != ""
		  deposit = deposit.to_f
		else
			deposit = nil
		end	
		price = params[:price]
		if price != ""
		  price = price.to_f
		else
			price = nil
		end				
		distance = params[:miles]
		if distance != nil
			distance = distance.to_f
		end

		lat = params[:lat].to_f
		lng = params[:lng].to_f
		search_term = params[:search]

		zip_code = params[:zip]
		if zip_code != nil
			puts "--------------------------This is your zip #{zip_code}"
			coords = Geocoder.search(zip_code).first.coordinates
			lat = coords[0]
			lng = coords[1]
		end
		if  lat != nil && lng != nil
		 	if current_user
		 		items = current_user.nearby_items_by_cat(category, [lat, lng], search_term, deposit, price, distance)
			else
				items = User.nearby_items_by_cat(category, [lat, lng],search_term, deposit, price, distance)
			end
		 else
		 	if current_user 
		 		items = current_user.nearby_items_by_cat(category, nil, search_term, deposit, price, distance)
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
			:items => items.as_json(:include => :user, :methods => :avatar_url),
			:location => {:lat => lat, :lng => lng}
			}
		end		
	end
end
