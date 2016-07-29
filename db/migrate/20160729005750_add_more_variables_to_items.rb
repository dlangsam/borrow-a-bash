class AddMoreVariablesToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :deposit, :float, default: 0.0
  	add_column :items, :price, :float, default: 0.0
  end
end
