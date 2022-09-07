class AddColumnsToApplications < ActiveRecord::Migration[5.2]
  def change
    change_table :applications do |t|
      t.string :city
      t.string :state
      t.string :zipcode
    end
  end
end
