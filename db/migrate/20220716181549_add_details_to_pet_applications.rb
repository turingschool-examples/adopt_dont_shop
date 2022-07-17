class AddDetailsToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :app_status, :string
  end
end
