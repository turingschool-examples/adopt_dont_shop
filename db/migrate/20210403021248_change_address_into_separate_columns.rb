class ChangeAddressIntoSeparateColumns < ActiveRecord::Migration[5.2]
  def change
    change_table :applications do |t|
      t.remove :address
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
    end
  end
end
