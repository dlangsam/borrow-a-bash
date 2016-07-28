module ApplicationHelper
	def resource_name
		:user		
	end		

	def resource		
		@resource ||= User.new		
	end		

	def devise_mapping		
		@devise_mapping ||= Devise.mappings[:user]		
	end

	def lat_lng
  		@lat_lng = cookies[:lat_lng].split("|")
	end


end
