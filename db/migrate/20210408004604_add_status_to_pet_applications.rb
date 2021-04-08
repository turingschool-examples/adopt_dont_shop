class AddStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :status, :string
    change_column_default :pet_applications, :status, "pending"
  end
end
