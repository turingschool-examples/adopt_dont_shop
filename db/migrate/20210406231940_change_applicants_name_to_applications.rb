class ChangeApplicantsNameToApplications < ActiveRecord::Migration[5.2]
  def change
     rename_table :applicants, :users

     remove_column :users, :status
     remove_column :users, :description
  end
end
