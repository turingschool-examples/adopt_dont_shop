class CreateSurveyPets < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_pets do |t|
      t.references :pet, foreign_key: true
      t.references :survey, foreign_key: true
    end
  end
end
