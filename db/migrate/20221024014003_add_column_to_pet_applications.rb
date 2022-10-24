class AddColumnToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :pet_status, :string, default: 'Pending'
  end
end
