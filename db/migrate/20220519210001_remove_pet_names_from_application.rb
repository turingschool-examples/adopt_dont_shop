class RemovePetNamesFromApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :pet_names, :string
  end
end
