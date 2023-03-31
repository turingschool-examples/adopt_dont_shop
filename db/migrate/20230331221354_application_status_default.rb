class ApplicationStatusDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :application_status, :string, default: "In Progress"
  end
end
