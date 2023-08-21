class DeliveryStatusJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # Extract data from the webhook request
    message_id = params[:message_id]
    status = params[:status]

    message = SendMessage.find_by(message_id:)
    message&.update(attempt_status: status.to_s)
    head :ok
  end
end
