class AddStateToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :street_address, :string
    add_column :shelters, :state, :string
    add_column :shelters, :zipcode, :integer
  end
end
