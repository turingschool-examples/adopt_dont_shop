class ChangeApplicationColumnNulls < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :name, :string
    change_column_null :applications, :name, false
    change_column_null :applications, :address, false
    change_column_null :applications, :city, false
    change_column_null :applications, :state, false
    change_column_null :applications, :zipcode, false
  end
end
