class CategoriesController < ApplicationController
	def show
		if current_user
		
			@items = current_user.nearby_items_by_cat(params[:id].to_i)
		else
			coords = lat_lng

			if  false && coords
				@items = User.nearby_items_by_cat(location[0], location[1])
			else
				@items = Category.find(params[:id]).items
			end
		end
	end

	def lat_lng
  		@lat_lng = cookies[:lat_lng].split("|")
	end

end
