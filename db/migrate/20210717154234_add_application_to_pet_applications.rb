class AddApplicationToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_reference :pet_applications, :application, foreign_key: true
  end
end
