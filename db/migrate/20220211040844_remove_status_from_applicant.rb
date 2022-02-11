class RemoveStatusFromApplicant < ActiveRecord::Migration[5.2]
  def change
    remove_column :applicants, :status, :integer
  end
end
