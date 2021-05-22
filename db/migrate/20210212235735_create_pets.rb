# frozen_string_literal: true

class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.boolean :adoptable
      t.integer :age
      t.string :breed
      t.string :name
      t.references :shelter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
