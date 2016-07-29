class AddIsPublishedToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :is_published, :boolean, default: true
  end
end
