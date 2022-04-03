class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.text :description
      t.string :app_status
      
      t.timestamps 
    end
  end
end
