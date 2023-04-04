class AddDefaultValueToAdoptableForPets < ActiveRecord::Migration[5.2]
  def change
    change_column_default :pets, :adoptable, from: nil, to: true
  end
end
