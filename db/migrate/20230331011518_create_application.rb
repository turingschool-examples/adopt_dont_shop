class CreateApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :reason, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
