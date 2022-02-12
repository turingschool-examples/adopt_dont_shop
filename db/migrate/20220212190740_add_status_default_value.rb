class AddStatusDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :status, :integer, default: 0
  end
end
