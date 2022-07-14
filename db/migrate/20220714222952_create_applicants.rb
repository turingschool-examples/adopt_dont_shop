class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.text :address
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
