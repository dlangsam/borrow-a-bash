class Message < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :recipient, class_name: "User"

	def mark_read
		if !is_read?
			self.is_read = true
		end
		self.save
	end



end
