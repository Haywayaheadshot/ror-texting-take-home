class Dev::SendMessagesController < ApplicationController
  def index
    # List all messages
    @messages = SendMessage.all
    render json: @messages,
      only: %i[id to_number message callback_url]
  end

  def provider_one
    # Send back an id when a message is created
    to_number = create_message_params[:to_number]
    message = create_message_params[:message]
    callback_url = create_message_params[:callback_url]

    @new_message = SendMessage.create(to_number:, message:, callback_url:)

    if @new_message.save?
        render json: { message: "Return an id"}
    else
        render json: { message: "There is an error. Check again"}
    end

  end

  private

  def create_message_params
    params.permit(:to_number, :message, :callback_url)
  end
end
