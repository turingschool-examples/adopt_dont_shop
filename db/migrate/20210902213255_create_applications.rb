class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :reason, required: false

      t.timestamps
    end
  end
end
