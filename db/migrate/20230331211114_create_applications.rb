class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :description

      t.timestamps
    end
    add_column :applications, :status, :integer, default: 0
  end
end
