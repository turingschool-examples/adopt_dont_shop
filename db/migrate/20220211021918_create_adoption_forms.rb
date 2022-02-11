class CreateAdoptionForms < ActiveRecord::Migration[5.2]
  def change
    create_table :adoption_forms do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
