class ChangeUserIdToItemIdInItemCategories < ActiveRecord::Migration[5.0]
  def change
  	rename_column :item_categories, :user_id, :item_id
  end
end
