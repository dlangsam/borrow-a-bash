class Item < ApplicationRecord
	belongs_to :user
	has_many :item_category
	has_many :categories, through: "item_category"
	 has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/assets/balloons.jpg"
  	 validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 	 def self.generate_map(lat, lng, items)
  	 	url = "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=13&size=600x300&maptype=roadmap"
  	 	items.each do |item| 
  	 		url = "#{url}&markers=color:blue%7C#{item.user.latitude},#{item.user.longitude}"
  	 	end
  	 	url = "#{url}&key=#{ENV.fetch('GOOGLE_API_KEY')}"
  	 end
  	 def change_published
  	 	if self.is_published
  	 		self.is_published = false
  	 	else
  	 		self.is_published = true
  	 	end
  	 	self.save;
  	 end
  	 def generate_map
  	 	lat = user.latitude
  	 	lng = user.longitude
  	 	url = "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=13&size=300x300&maptype=roadmap"
  	 	url = "#{url}&markers=color:blue%7C#{lat},#{lng}"
  	 	url = "#{url}&key=#{ENV.fetch('GOOGLE_API_KEY')}"
  	  
     end
    def avatar_url
        avatar.url(:medium)
     end

 

end
