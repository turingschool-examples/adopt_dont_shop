class AddDescriptionAndStatusToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :status, :string, default: "In Progress"
    add_column :applicants, :description, :string
  end
end
