class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :last
      t.string :first
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
