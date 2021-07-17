class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.string :pet_app_status

      t.timestamps 
    end
  end
end
