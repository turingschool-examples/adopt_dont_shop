class RemovePetsFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :pets, :string
  end
end
