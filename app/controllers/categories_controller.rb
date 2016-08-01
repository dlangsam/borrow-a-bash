class CategoriesController < ApplicationController

	def show
		@search_term = params[:search_word]
		puts "Your search term is  #{@search_term}"
		if params[:id] != nil
			@category = Category.find(params[:id])
		else
			@category = nil
		end
		@zip = ""
		if current_user
			@zip = "#{current_user.get_zip_code}"
		end
		if @zip == ""
			lat = cookies[:lat]
			lng = cookies[:lng]
			if(lat !=nil && lng != nil)
				puts "test#{lat},#{lng}"
				result = Geocoder.search("#{lat},#{lng}").first
				if result
					@zip = result.postal_code
				else
					@zip = ""
				end
			end
		end		
	end
end
