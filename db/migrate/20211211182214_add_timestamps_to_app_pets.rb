class AddTimestampsToAppPets < ActiveRecord::Migration[5.2]
  def change
    add_column :app_pets, :created_at, :datetime, null: false
    add_column :app_pets, :updated_at, :datetime, null: false
  end
end
