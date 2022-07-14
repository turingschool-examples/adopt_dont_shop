class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :names_pets_wanted
      t.string :application_status

      t.timestamps
    end
  end
end
