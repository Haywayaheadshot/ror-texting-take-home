require 'application_system_test_case'

class SendMessagesTest < ApplicationSystemTestCase
  setup do
    @send_message = send_messages(:one)
  end

  test 'visiting the index' do
    visit send_messages_url
    assert_selector 'h1', text: 'Send messages'
  end

  test 'should create send message' do
    visit send_messages_url
    click_on 'New send message'

    click_on 'Create Send message'

    assert_text 'Send message was successfully created'
    click_on 'Back'
  end

  test 'should update Send message' do
    visit send_message_url(@send_message)
    click_on 'Edit this send message', match: :first

    click_on 'Update Send message'

    assert_text 'Send message was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Send message' do
    visit send_message_url(@send_message)
    click_on 'Destroy this send message', match: :first

    assert_text 'Send message was successfully destroyed'
  end
end
