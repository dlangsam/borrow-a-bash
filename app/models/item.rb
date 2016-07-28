class Item < ApplicationRecord
	belongs_to :user
	has_many :item_category
	has_many :categories, through: "item_category"
	 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/balloons.jpg"
  	 validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


end
