class AddColumntoPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :status, :string, default: "0"
  end
end
