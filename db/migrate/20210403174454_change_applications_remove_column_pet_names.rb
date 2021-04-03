class ChangeApplicationsRemoveColumnPetNames < ActiveRecord::Migration[5.2]
  def change
    change_table :applications do |t|
      t.remove :pet_names
    end
  end
end
