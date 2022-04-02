class ChangeColumnStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applications, :status, 0
    change_column_default :pet_applications, :status, 0
  end
end
