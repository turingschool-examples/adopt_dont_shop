class AddNameToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :name, :string
  end
end
