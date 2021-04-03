class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.string :status
      t.string :cover_letter

      t.references :pet, foreign_key: true
      t.references :applicant, foreign_key: true
    end
  end
end
