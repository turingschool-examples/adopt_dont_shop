class AddStatusColumn < ActiveRecord::Migration[5.2]
  def change
    change_table :pet_applications do |t|
      t.string :status
    end
  end
end
