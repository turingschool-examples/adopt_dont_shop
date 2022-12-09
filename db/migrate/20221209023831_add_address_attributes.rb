class AddAddressAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :city, :string
    add_column :applicants, :state, :string
    add_column :applicants, :zip_code, :integer
  end
end
