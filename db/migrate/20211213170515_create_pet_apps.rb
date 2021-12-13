class PetApps < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_apps do |t|
      t.string :name
      t.string :address
      t.string :pet_name
      t.string :application_status

      t.timestamps

      t.references :shelters, foreign_key: true
      t.references :pets, foreign_key: true
    end
  end
end
