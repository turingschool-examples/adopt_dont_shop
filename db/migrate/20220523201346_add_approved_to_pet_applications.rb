class AddApprovedToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :approved, :boolean, default: false  
  end
end
