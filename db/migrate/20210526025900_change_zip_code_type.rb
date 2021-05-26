class ChangeZipCodeType < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :zip_code, :string
  end
end
