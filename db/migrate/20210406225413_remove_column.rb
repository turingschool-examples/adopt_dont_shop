class RemoveColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :pet_id
  end
end
