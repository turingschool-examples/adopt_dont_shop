class AddFullAddressToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :street_address, :string
    add_column :shelters, :zip_code, :integer
  end
end
