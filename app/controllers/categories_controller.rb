class CategoriesController < ApplicationController
	def show
		if current_user
		
			@items = current_user.nearby_items_by_cat(params[:id].to_i)
		else
			##make a temporary user with location??
			@items = Category.find(params[:id]).items
		end
	end

end
