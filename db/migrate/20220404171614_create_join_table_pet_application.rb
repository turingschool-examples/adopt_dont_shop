class CreateJoinTablePetApplication < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pets, :applications do |t|
      t.timestamps 
    end
  end
end
