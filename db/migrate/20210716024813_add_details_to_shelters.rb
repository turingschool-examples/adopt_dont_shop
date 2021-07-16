class AddDetailsToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :address, :string
    add_column :shelters, :state, :string
    add_column :shelters, :zip, :string
  end
end
