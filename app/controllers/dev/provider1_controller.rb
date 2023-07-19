class Dev::Provider1Controller < ApplicationController
  def index
    # List all messages
    @messages = SendMessage.all
    { json: @messages,
      only: %i[id to_number message callback_url] }
  end
end
