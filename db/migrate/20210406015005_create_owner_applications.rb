class CreateOwnerApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :owner_applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :pets
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
