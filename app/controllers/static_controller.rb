class StaticController < ApplicationController
	def index
	end
	def find_users
		lat = current_user.latitude
		long = current_user.longitude
		@nearby_users = User.near([lat, long], 50)
		render 'nearby'
	end
end
