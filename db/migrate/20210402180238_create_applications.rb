class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :adopting_applications do |t|
      t.string :full_name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :description
      t.boolean :in_progress
      t.boolean :accepted
      t.boolean :declined
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
