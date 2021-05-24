class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:pet_applications, :status, from: "Pending", to: "In Progress")
  end
end
