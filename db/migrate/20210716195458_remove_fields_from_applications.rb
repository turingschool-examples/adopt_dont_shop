class RemoveFieldsFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :applicant_lastname, :string
    remove_column :applications, :applicant_firstname, :string
  end
end
