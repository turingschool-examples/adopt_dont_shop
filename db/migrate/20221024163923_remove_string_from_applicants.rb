class RemoveStringFromApplicants < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants, :string, :string
  end
end
