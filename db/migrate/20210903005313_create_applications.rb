class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string  :name
      t.string  :address
      t.string  :city
      t.string  :state
      t.integer :zip
      t.string  :description, default: ""
      t.string  :status, default: "In Progress"

      t.timestamps
    end
  end
end
