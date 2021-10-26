class PreventNullsInCreation < ActiveRecord::Migration[6.1]
  def change
    change_column_null :pet_applications, :name, false
    change_column_null :pet_applications, :street, false
    change_column_null :pet_applications, :city, false
    change_column_null :pet_applications, :state, false
    change_column_null :pet_applications, :zip, false
  end
end
