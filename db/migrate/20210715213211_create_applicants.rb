class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :home_description
      t.string :status

      t.timestamps
    end
  end
end
