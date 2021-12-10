class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :state
      t.integer :zip
      t.string :street
      t.references :application, foreign_key: true
    end
  end
end
