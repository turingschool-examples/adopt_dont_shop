class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :owner_application, foreign_key: true
      t.references :pet, foreign_key: true
      t.string :app_status

      t.timestamps
    end
  end
end
