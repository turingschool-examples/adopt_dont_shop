class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :post_code
      t.string :good_owner

      t.timestamps
    end
  end
end
