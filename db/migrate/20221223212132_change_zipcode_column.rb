class ChangeZipcodeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :zipcode, :zip_code
  end
end
