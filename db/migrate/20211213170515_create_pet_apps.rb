class CreatePetApps < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_apps do |t|
      t.string :name
      t.string :address
      t.string :pet_name
      t.string :application_status

      t.timestamps
    end
  end
end
