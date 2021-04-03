class AddInProgressColumnToAdoptingApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :adopting_applications, :pending , :boolean
  end
end
