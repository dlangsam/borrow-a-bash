class ItemsApiController < ApplicationController

	def create
		category = Category.find_by(id: params[:category_id])
		unless category
			render status: 400, json: {error: "Category not found"}
			return
		end
		item = Item.new(items_params)
		if item.save
			category.items.push(item)
			render json: item
		else
			render status: 400, json: {error: "Item wasn't made"}
		end
	end
	def change_published
		item = Item.find_by(id: params[:id])
		unless item
			render status: 400, json: {error: "Item not found"}
			return
		end
		if item.change_published
			render json: item
		else
			render status: 400, json: {error: "Published status of item not changed"}
		end
	end
	def remove_image
		item = Item.find_by(id: params[:id])
		unless item
			render status: 400, json: {error: "Item not found"}
			return
		end
		item.avatar.destroy
		if item.save
			render json: item
		else
			render status: 400, json: {error: "Published status of item not changed"}
		end
	end

	def show
		search_term = params[:search_term]

		distance = params[:miles].to_f
		lat = params[:lat].to_f
		lng = params[:lng].to_f
		
		zip_code = params[:zip]
		if zip_code != nil && lat != nil && lng != nil
			coords = User.get_zip_code_coords(zip_code)
			lat = coords[0]
			lng = coords[1]
		end
		if  lat != nil && lng != nil
		 	if current_user
		 		items = current_user.nearby_items_by_search(search_term, [lat, lng], distance)
			else
				items = User.nearby_items_by_search(search_term, [lat, lng], distance)
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
		end		
	end


	private
	def items_params
		params.require(:item).permit(:user_id, :name, :description, :avatar)
	end



end
