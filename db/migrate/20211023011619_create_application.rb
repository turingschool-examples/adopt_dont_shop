class CreateApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :good_fit
      t.string :status
      t.references :pets, foreign_key: true

      t.timestamps
    end
  end
end
