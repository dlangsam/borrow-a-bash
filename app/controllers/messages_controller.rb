class MessagesController < ApplicationController
	before_action :authenticate_user!
	def index
		@messages = current_user.in_box
	end
	def show
		@message = Message.find_by(id: params[:id])
		if current_user.id == @message.recipient_id
			@message.mark_read
		end
	end
	def new
		@message = Message.new
	end
	def create
		@message = Message.new(message_params)
		recipient = User.find_by(username: params[:username])
		if recipient == nil
			flash[:message] = 'Username: ' + params[:username] + ' does not exist.'
			render 'new'
		else
	
		@message.sender_id = current_user.id
		@message.recipient_id = recipient.id
		if @message.save

			redirect_to messages_url
		else
			flash[:message] = 'Error sending message.'
			render 'new'
		end
	end
	end
	private
	def message_params
		params.require(:message).permit( :content)
	end
end
