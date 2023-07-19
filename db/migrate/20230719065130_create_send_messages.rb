class CreateSendMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :send_messages do |t|
      t.integer :to_number
      t.string :message
      t.string :callback_url

      t.timestamps
    end
  end
end
