class PetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.belongs_to :application, index: true, foreign_key: true
      t.belongs_to :pet, index: true, foreign_key: true
    end
  end
end
