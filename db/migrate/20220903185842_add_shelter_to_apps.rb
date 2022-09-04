class AddShelterToApps < ActiveRecord::Migration[5.2]
  def change
    add_reference :apps, :shelter, foreign_key: true
  end
end
