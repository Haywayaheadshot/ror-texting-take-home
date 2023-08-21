class DeliveryStatusJob < ApplicationJob
  queue_as :default

  def perform(new_message)
    # Do something later

    if new_message.save
      puts('Message Saved')
    else
      Rails.logger.error('Message not saved')
    end
  rescue StandardError => e
    Rails.logger.error("An error occurred: #{e.message}")
  end
end
