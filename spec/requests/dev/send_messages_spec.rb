require 'rails_helper'
require 'json'

RSpec.describe Dev::SendMessagesController, type: :request do
  describe 'POST #provider_one' do
    url = 'https://dd90-181-214-93-162.ngrok-free.app'

    it 'creates a message using Provider 1 and checks its status' do
      # Prepare the payload for the provider_one action
      payload = {
        to_number: '1234567890',
        message: 'Test message'
      }

      # Make the POST request to provider_one
      post "#{url}/dev/provider1", params: payload.to_json, headers: { 'Content-Type' => 'application/json' }

      # Expect a successful response with HTTP status 200
      if response.code == 200
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Parse the response body to get the message_id
        response_body = JSON.parse(response.body)
        message_id = response_body['message_id']
        status = response_body['status']

        # Update the status of the message
        post "#{url}/dev/delivery_status", params: { message_id:, status: }

        # Expect a successful response with HTTP status 200
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('text/html')

        # Now, check the status of the message using the find_message_status action
        post "#{url}/dev/check_attempt_status", params: { message_id: }

        # Expect a successful response with HTTP status 200
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json; charset=utf-8')

        # Parse the response body to get the status and message_id
        status_response_body = JSON.parse(response.body)
        status_response_body['status']
        returned_message_id = status_response_body['message_id']

        # Ensure the returned message_id matches the original one
        expect(returned_message_id).to eq(message_id)
      end
    end

    it "returns code: 500 and 'System is offline now. Please try later' if provider is down" do
      # Prepare the payload for the provider_one action
      payload = {
        to_number: '1234567890',
        message: 'Test message'
      }

      # Make the POST request to provider_one
      post "#{url}/dev/provider1", params: payload.to_json, headers: { 'Content-Type' => 'application/json' }

      # Expect a response with code: 500 and the appropriate error message
      if response.code == 500
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')

        # Parse the response body to get the error message
        response_body = JSON.parse(response.body)
        expect(response_body['code']).to eq(500)
        expect(response_body['message']).to eq('System is offline now. Please try later')
      end
    end

    it 'checks if the attempt_status of message is equal to that of the API call ' do
      # Prepare the payload for the provider_one action
      payload = {
        to_number: '1234567890',
        message: 'Test message'
      }

      # Make the POST request to provider_one
      post "#{url}/dev/provider1", params: payload.to_json, headers: { 'Content-Type' => 'application/json' }

      # Check if response.code == 200 and check for response.message id
      if response.code == 200
        response_body = JSON.parse(response.body)
        message_id = response_body['message_id']

        # Now, check the status of the message using the find_message_status action
        post "#{url}/dev/check_attempt_status", params: { message_id: }

        # Expect a successful response with HTTP status 200
        expect(response).to have_http_status(200)

        # Parse the response body to get the status and message_id
        status_response_body = JSON.parse(response.body)
        status_response = status_response_body['status']
        returned_message_id = status_response_body['message_id']

        # Ensure the returned message_id matches the original one
        expect(returned_message_id).to eq(message_id)

        # Now, check the status of the message using the find_message_status action
        post "#{url}/dev/find_message", params: { message_id: returned_message_id }

        # Expect a successful response with HTTP status 200
        expect(response).to have_http_status(200)

        # Parse the response body to get the status and message_id
        find_message_response_body = JSON.parse(response.body)
        find_message_response_body['attempt_status']
        find_message_returned_message_id = find_message_response_body['message_id']

        # Expect a successful response with HTTP status 200
        expect(find_message_returned_message_id).to eq(returned_message_id)
        expect(attempt_status_respons).to eq(status_response)

      end
    end
  end
end
