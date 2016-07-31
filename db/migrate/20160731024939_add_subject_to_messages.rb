class AddSubjectToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :subject, :string, default: ""
  end
end
