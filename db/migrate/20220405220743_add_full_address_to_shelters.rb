class AddFullAddressToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :full_address, :string
  end
end
