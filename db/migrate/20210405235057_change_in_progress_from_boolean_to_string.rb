class ChangeInProgressFromBooleanToString < ActiveRecord::Migration[5.2]
  def change
    change_column :applicants_pets, :status, :string
  end
end
