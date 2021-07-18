class AddColumnApplications < ActiveRecord::Migration[5.2]
  def change
    change_table :applications do |t|
      t.rename :address, :street_address
      t.change_default :status, 'In Progess'
      t.column :city, :string
      t.column :state, :string
      t.column :zip_code, :string
    end
  end
end
