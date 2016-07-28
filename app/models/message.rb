class Message < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :recipient, class_name: "User"

	def mark_read
		if !is_read?
			self.is_read = true
		end
		self.save
	end
	def prepare_message(item)
		to_user = item.user
		generate_message_content(item, to_user.username)
		return to_user
	end

	def generate_message_content(item, username)
		self.content = "Hi #{username}. I'm interested in borrowing the #{item.name} that you listed!"
	end



end
