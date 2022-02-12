class RemoveColumnFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :pending, :boolean
  end
end
