class AddStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :status, :integer
  end
end
