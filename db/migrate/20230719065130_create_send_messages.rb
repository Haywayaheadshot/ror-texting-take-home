class CreateSendMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :send_messages do |t|
      t.bigint :to_number
      t.string :message
      t.string :attempt_status
      t.string :message_id

      t.timestamps
    end
  end
end
