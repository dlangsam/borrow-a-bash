module StaticHelper

	def locaction
  		@lat_lng = cookies[:lat_lng].split("|")
	end
end
