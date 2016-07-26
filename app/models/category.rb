class Category < ApplicationRecord
	has_many :item_category
	has_many :items, through: "item_category"
end
