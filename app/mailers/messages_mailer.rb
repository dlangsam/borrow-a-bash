class MessagesMailer < ApplicationMailer
	default from: "devorah@borrowabash.co"
 	def new_message_email(message)
 		@message = message
 		mail(to: @message.recipient.email,  subject: "New message from BorrowABash")
 	end
end
