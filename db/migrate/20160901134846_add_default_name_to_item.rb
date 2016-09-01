class AddDefaultNameToItem < ActiveRecord::Migration[5.0]
  def change
  	change_column :items, :name, :string, default: ""
  end
end
