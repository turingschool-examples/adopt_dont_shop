class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :state
      t.string :city
      t.string :zip
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
