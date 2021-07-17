class AddShelterToPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :shelter, foreign_key: true
  end
end
