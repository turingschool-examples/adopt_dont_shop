class AddPetitionToPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :petition, foreign_key: true
  end
end
