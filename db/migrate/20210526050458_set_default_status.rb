class SetDefaultStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :status, :string, :default => "Pending"
  end
end
