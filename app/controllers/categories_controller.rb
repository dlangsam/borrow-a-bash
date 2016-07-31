class CategoriesController < ApplicationController
	def show
		@category = Category.find(params[:id])
		@zip = ""
		if current_user
			@zip = "#{current_user.get_zip_code}"
		end
		if @zip == ""
			lat = cookies[:lat]
			lng = cookies[:lng]
			if(lat !=nil && lng != nil)
				puts "test#{lat},#{lng}"
				@zip = Geocoder.search("#{lat},#{lng}").first.postal_code
			end
		end		
	end
end
