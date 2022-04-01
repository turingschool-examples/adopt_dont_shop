class DeleteString < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :string
  end
end
