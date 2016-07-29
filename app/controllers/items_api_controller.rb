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
	private
	def items_params
		params.require(:item).permit(:user_id, :name, :description, :avatar)
	end

end
