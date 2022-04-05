class RemoveApplicationApprovedAndRejectedIds < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :approved_pet_ids
    remove_column :applications, :rejected_pet_ids
  end
end
