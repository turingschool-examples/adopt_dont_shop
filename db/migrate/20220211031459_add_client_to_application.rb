class AddClientToApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :client, foreign_key: true
  end
end
