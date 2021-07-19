class CreatePetApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applicants do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :applicant, null: false, foreign_key: true
    end
  end
end
