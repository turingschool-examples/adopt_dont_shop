class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :applications, :description, :string, default: ""
  end
end
