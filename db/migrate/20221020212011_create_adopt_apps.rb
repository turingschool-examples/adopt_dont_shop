class CreateAdoptApps < ActiveRecord::Migration[5.2]
  def change
    create_table :adopt_apps do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
