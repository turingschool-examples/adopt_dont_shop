class AddDistinctAddressFieldsToApplications < ActiveRecord::Migration[5.2]
  def change
    change_table :applications do |t|
      t.remove :full_address
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
    end
  end
end
