class ChangeInProgressToStatusAndChangeFromBooleanToString < ActiveRecord::Migration[5.2]
  def change
    rename_column :applicants_pets, :in_progress, :status
  end
end
