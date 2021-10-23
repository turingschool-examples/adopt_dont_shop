class AddDefaultValues < ActiveRecord::Migration[5.2]
  def change
    change_column_default :application_pets, :status, from: nil, to: "Pending"
    change_column_default :applications, :status, from: nil, to: "In Progress"
  end
end
