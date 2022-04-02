class AddStatusToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :status, :integer
  end
end
