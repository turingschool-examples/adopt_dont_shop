class RemoveApplicationFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :application_id
  end
end
