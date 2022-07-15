class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :name, :string, null: false
    change_column :applications, :street, :string, null: false
    change_column :applications, :city, :string, null: false
    change_column :applications, :state, :string, null: false
    change_column :applications, :zipcode, :integer, null: false
    change_column :applications, :status, :string, default: "In Progress"
    change_column :applications, :description, :string, null: false
  end
end
