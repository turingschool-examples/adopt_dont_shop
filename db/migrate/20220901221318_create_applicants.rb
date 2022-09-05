class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :zip, null: false
      t.string :description, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
