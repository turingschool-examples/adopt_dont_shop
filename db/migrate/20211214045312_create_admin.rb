class CreateAdmin < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
