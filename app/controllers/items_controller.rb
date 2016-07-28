class ItemsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :show]
	def index
		@current_user = current_user
		@items = current_user.items
		@item = current_user.items.new
	end
	def show
		@item = Item.find_by(id: params[:id])

	end
	def new
		@item = current_user.items.new
	end
	def create
		category = Category.find(params[:categories])
		#category = Category.find(1)
		@item = Item.new(items_params)
	
		@item.save
		category.items.push(@item)

		redirect_to user_items_url(current_user.id)
	
	end
	def item
		@item = Item.find_by(id: params[:id])
	end
	private
	def items_params
		params.require(:item).permit(:user_id, :name, :description, :avatar)
	end



end
