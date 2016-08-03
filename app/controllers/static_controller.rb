class StaticController < ApplicationController
	def index
	end
	def nearby
		@nearby_items = current_user.nearby_items
	end
	def letsencrypt
		render plain: "BajdvKqOG0aU59zo2_OYxwUhI-jqv1zAIbNU1D5hNSg.gPUKZqF8ANUlpe5HLXc4uByh5_NI3mlb6ypClzNqEnE"
	end
end
