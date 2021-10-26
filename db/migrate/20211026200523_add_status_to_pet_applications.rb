class AddStatusToPetApplications < ActiveRecord::Migration[6.1]
  def change
    change_table :pet_applications do |t|
      t.integer :status, default: 0, null: false
    end
  end
end
