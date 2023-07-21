class CreateInvalidNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :invalid_numbers do |t|
      t.bigint :number

      t.timestamps
    end
  end
end
