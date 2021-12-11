class CreatePetApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applicants do |t|
      t.references :pet, foreign_key: true
      t.references :applicant, foreign_key: true
      t.timestamps
    end
  end
end
