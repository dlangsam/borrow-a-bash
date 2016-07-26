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


end
