class AddIndexToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_index :pet_applications, [:pet_id, :application_id], :unique => true
  end
end
