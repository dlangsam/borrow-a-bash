class ChangeZipCodeInUsersToString < ActiveRecord::Migration[5.0]
  def change
  	 change_column :users, :zip_code, :string
  end
end
