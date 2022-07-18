class AddAppStatusToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :app_status, :string
  end
end
