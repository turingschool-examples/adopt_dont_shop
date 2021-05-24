class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :state
      t.string :city
      t.integer :zip_code
      t.string :address
      t.string :description, default: '(Empty by default)'
      t.string :status, default: "In Progress"
      t.timestamps
    end
  end
end
