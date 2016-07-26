class ItemsApiController < ApplicationController

	def create
		category = category.find_by(id: params[:category_id])
		unless category
			render status: 400, json: {error: "Category not found"}
			return
		end
		item = Item.new(items_params)
		if item.save
			category.items.push(item)
			render json: item
		else
			render status: 400, json: {error: "Item not made"}
		end
	end
	private
	def items_params
		params.require(:item).permit(:user_id, :name, :description)
	end

end
