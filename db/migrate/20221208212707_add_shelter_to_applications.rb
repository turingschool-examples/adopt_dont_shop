class AddShelterToApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :shelter, foreign_key: true
  end
end
