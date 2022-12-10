class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.boolean :adoptable
      t.references :shelter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
