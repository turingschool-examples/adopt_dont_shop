class AddStatusToPetApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :status, :integer, default: 0
  end
end
