class RemoveGoodHomeFromPetPetitions < ActiveRecord::Migration[5.2]
  def change
    remove_column :pet_petitions, :good_home, :string
  end
end
