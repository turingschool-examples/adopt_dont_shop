class AddColumnHasBeenAcceptedToJoins < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :was_approved, :boolean
  end
end
