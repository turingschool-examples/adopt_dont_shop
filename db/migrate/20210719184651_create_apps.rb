class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :zip, null: false
      t.text :description
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
