class AddPetsToApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :pets, foreign_key: true
  end
end
