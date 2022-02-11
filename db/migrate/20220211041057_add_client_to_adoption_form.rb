class AddClientToAdoptionForm < ActiveRecord::Migration[5.2]
  def change
    add_reference :adoption_forms, :client, foreign_key: true
  end
end
