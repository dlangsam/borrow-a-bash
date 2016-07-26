class ItemsApiController < ApplicationController

	def create
		item = Item.new(items_params)
		if item.save
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
