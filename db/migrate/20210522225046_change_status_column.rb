class ChangeStatusColumn < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:pet_applications, :status, from: nil, to: "Pending")
  end
end
