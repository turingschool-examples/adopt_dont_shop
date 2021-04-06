class ChangeStatusDefaultToInProgress < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applicants_pets, :status, "in_progress"
  end
end
