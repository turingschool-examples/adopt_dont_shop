class AddTimestampsToPetApplicationPets < ActiveRecord::Migration[6.1]
  def change
    change_table :pet_application_pets do |t|
      t.timestamps
    end
  end
end
