class AddStatusToPetPetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_petitions, :status, :string, default: 'Undecided'
  end
end
