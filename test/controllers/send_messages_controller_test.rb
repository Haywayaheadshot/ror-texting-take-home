require 'test_helper'

class SendMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @send_message = send_messages(:one)
  end

  test 'should get index' do
    get send_messages_url
    assert_response :success
  end

  test 'should get new' do
    get new_send_message_url
    assert_response :success
  end

  test 'should create send_message' do
    assert_difference('SendMessage.count') do
      post send_messages_url, params: { send_message: {} }
    end

    assert_redirected_to send_message_url(SendMessage.last)
  end

  test 'should show send_message' do
    get send_message_url(@send_message)
    assert_response :success
  end

  test 'should get edit' do
    get edit_send_message_url(@send_message)
    assert_response :success
  end

  test 'should update send_message' do
    patch send_message_url(@send_message), params: { send_message: {} }
    assert_redirected_to send_message_url(@send_message)
  end

  test 'should destroy send_message' do
    assert_difference('SendMessage.count', -1) do
      delete send_message_url(@send_message)
    end

    assert_redirected_to send_messages_url
  end
end
