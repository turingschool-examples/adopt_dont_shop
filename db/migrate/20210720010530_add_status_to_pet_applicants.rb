class AddStatusToPetApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applicants, :status, :string
  end
end
