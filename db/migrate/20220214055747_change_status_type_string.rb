class ChangeStatusTypeString < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :status, :string, default: "0"
  end
end
