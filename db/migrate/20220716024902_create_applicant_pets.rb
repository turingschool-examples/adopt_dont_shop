class CreateApplicantPets < ActiveRecord::Migration[5.2]
  def change
    create_table :applicant_pets do |t|
      t.references :applicant, foreign_key: true
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
