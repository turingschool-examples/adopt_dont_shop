class AddApplicationToPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :pet_application, foreign_key: true
  end
end
