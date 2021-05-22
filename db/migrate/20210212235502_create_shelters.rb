# frozen_string_literal: true

class CreateShelters < ActiveRecord::Migration[5.2]
  def change
    create_table :shelters do |t|
      t.boolean :foster_program
      t.string :name
      t.string :city
      t.integer :rank

      t.timestamps
    end
  end
end
