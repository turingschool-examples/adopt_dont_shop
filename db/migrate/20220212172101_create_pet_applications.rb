class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|

      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
      t.string :status

      # t.unique (:pet, :application)

      t.timestamps
    end
  end
end
