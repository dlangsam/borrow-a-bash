class CreateItemCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :item_categories do |t|
    	t.integer :user_id
    	t.integer :category_id

      t.timestamps
    end
  end
end
