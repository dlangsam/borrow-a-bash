class ItemsController < ApplicationController
	before_action :authorize_user, only: [:show]
	def index
		@current_user = current_user

		@items = current_user.items
		@item = current_user.items.new
	end
end
