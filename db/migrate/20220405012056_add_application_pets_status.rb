class AddApplicationPetsStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :status, :integer, default: 0
  end
end
