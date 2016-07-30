class ItemsController < ApplicationController
	before_action :authenticate_user!, only: [:index, :show, :message]
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
	def destroy
		item = Item.find(params[:id])
		item.destroy
		redirect_to user_items_url(current_user)
	end
	def create
		category = Category.find(params[:categories])
		@item = Item.new(items_params)
		@item.save
		category.items.push(@item)
		redirect_to user_items_url(current_user)
	end
	def edit
		@current_user = current_user
		@item = Item.find_by(id: params[:id])
	end
	def update
		
		@item = Item.find_by(id: params[:id])
		if  @item.update(items_params)
			@item.categories.clear
			params[:category].each do |cat_id|
				category = Category.find(cat_id)
				category.items.push(@item)
			end
			render "show"
		else
			render "edit"
		end

	end

	def item
		@item = Item.find_by(id: params[:id])
		@map_url = @item.generate_map
	end
	def message
		item = Item.find_by(id: params[:id])
		@message  = Message.new
		@user = @message.prepare_message(item)
	end
	private
	def items_params
		params.require(:item).permit(:user_id, :name, :description, :avatar, :depsoit, :price)
	end


end
