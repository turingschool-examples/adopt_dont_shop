class AddFullNameToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :applicant_fullname, :string
  end
end
