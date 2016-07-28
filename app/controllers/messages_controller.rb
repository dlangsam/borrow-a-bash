class MessagesController < ApplicationController
	def index
		@messages = current_user.in_box
		#sort these messages at some point??
	end
	def show

		@message = Message.find_by(id: params[:id])

	end
	def new
		@message = Message.new
	end
	def create
		@message = Message.new(message_params)
		@message.sender_id = current_user.id
		@message.save

	end
	private
	def message_params
		params.require(:message).permit(:recipient_id, :content)
	end
end
