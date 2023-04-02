class AddConditionToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :condition, :string, default: "Pending"
  end
end
