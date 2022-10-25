class AddRejectedToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :rejected, :boolean, :default => false
  end
end
