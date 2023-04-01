class CreateApplicants < ActiveRecord::Migration[5.2]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state, limit: 2
      t.string :zip, limit: 5
      t.string :good_home
      t.string :status, default: "In Progress"

      t.timestamps
    end
  end
end
