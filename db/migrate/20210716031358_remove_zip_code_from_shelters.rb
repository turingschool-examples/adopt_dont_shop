class RemoveZipCodeFromShelters < ActiveRecord::Migration[5.2]
  def change
    remove_column :shelters, :zip, :string
  end
end
