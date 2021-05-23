class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.timestamps
    end
  end
end
