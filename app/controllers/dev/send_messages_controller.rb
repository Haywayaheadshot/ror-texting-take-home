require 'net/http'
require 'uri'
require 'json'

class Dev::SendMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  MAIN_URL = 'https://mock-text-provider.parentsquare.com/'.freeze

  PROVIDER_1_URL = 'provider1'.freeze
  PROVIDER_2_URL = 'provider2'.freeze

  def provider_one
    # Send back an id when a message is created
    to_number = create_message_params[:to_number]
    message = create_message_params[:message]

    payload = {
      to_number:,
      message:,
      callback_url: 'https://e8cc-197-251-147-157.ngrok-free.app/delivery_status'
    }

    # Determine which provider to use based on the weighting
    provider_url = weighted_provider_url

    # Make the request to the external service (Provider 1 or Provider 2)
    attempt = make_request_to_provider(MAIN_URL + provider_url, payload)

    code_status = JSON.parse(attempt[:code])
    message_id = JSON.parse(attempt[:body])['message_id']

    if code_status == 200
      @new_message = SendMessage.create(
        to_number:,
        message:,
        attempt_status: '',
        message_id: message_id.to_s
      )

      render json: { code: code_status, message_id: @new_message.message_id } if @new_message.save
    elsif code_status == 500
      render json: { message: 'System is offline now. Please try later', code: code_status }
    end
  end

  def find_message_status
    message_id = params[:message_id]
    message = SendMessage.find_by(message_id:)

    render json: { status: message.attempt_status, message_id: }
  end

  def find_message
    message_id = params[:message_id]
    message = SendMessage.find_by(message_id:)

    render json: message
  end

  def delivery_status
    # Extract data from the webhook request
    message_id = params[:message_id]
    status = params[:status]

    message = SendMessage.find_by(message_id:)
    if status.to_s == 'invalid'
      @invalid_number = InvalidNumber.new(number: message.to_number)
      @invalid_number.save
    end
    message&.update(attempt_status: status)

    head :ok
  end

  private

  def create_message_params
    params.permit(:to_number, :message, :message_id, :status)
  end

  def weighted_provider_url
    rand <= 0.3 ? PROVIDER_1_URL : PROVIDER_2_URL
  end

  def make_request_to_provider(url, payload)
    # Prepare the request data
    uri = URI.parse(url)
    headers = { 'Content-Type' => 'application/json' }

    # Make the request to the external service
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = payload.to_json

    response = http.request(request)

    # Return both response.body and response.code
    { body: response.body, code: response.code }
  rescue Net::HTTPServerError
    # Retry through the other provider if one is down
    if url == PROVIDER_1_URL
      make_request_to_provider(MAIN_URL + PROVIDER_2_URL,
                               payload)
    else
      make_request_to_provider(MAIN_URL + PROVIDER_1_URL,
                               payload)
    end
  rescue StandardError
    # Handle other errors or if no provider is available
    { body: 'Message failed: No provider available', code: '500' }
  end
end
