class AddStatusToApplicant < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :status, :integer, default: 0
  end
end
