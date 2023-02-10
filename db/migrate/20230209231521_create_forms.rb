class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :description
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
