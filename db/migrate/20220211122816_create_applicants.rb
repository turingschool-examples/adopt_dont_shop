class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :zipcode
      t.text :description
      t.text :status
      t.timestamps
    end
  end
end
