class AddUuidToSendMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :send_messages, :uuid, :string
    add_index :send_messages, :uuid
  end
end
