class AddPetApplicationColumn < ActiveRecord::Migration[5.2]
  def change
    change_table :pet_applications do |t|
      t.string :reason
    end
  end
end
