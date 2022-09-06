class AddApplicationStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :application_status, :string
  end
end
