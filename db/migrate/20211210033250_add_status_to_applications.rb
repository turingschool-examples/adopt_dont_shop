class AddStatusToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :status, :string, :default => "In Progress"
  end
end
