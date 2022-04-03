class AddColumnsToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :approved_pet_ids, :text, array: true, default: []
    add_column :applications, :rejected_pet_ids, :text, array: true, default: []
  end
end
