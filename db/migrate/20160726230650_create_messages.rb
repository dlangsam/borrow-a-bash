class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content,          required: true
      t.integer :sender_id,     required: true
      t.integer :recipient_id,  required: true

      t.timestamps
    end
  end
end
