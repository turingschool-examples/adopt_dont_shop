class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.numeric :zipcode
      t.belongs_to :applicant

      t.timestamps
    end
  end
end
