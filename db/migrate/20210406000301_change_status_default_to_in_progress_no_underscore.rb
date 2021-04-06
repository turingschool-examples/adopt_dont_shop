class ChangeStatusDefaultToInProgressNoUnderscore < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applicants_pets, :status, "In Progress"
  end
end
