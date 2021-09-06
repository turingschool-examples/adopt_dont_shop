class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :description, required: false
      t.string :status, default: "In Progress"
      t.timestamps
    end
  end
end
