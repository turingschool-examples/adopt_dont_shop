class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :address_line_1
      t.string :city
      t.string :state
      t.string :zipcode
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
