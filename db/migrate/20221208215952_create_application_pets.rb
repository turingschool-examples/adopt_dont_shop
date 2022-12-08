class CreateApplicationPets < ActiveRecord::Migration[5.2]
  def change
    create_table :application_pets do |t|
      t.bigint :application_id
      t.bigint :pet_id
      t.boolean :status
    end
  end
end
