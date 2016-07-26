class Item < ApplicationRecord
	belongs_to :user
	has_many :item_category
	has_many :categories, through: "item_category"
end
