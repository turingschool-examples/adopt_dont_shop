class CreatePetApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.pet :references
      t.application :references

      t.timestamps
    end
  end
end
