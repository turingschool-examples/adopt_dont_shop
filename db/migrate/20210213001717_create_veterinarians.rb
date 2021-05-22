# frozen_string_literal: true

class CreateVeterinarians < ActiveRecord::Migration[5.2]
  def change
    create_table :veterinarians do |t|
      t.boolean :on_call
      t.integer :review_rating
      t.string :name
      t.references :veterinary_office, foreign_key: true

      t.timestamps
    end
  end
end
