class AddApplicaionToPets < ActiveRecord::Migration[5.2]
  def change
    add_reference :pets, :application, foreign_key: true
  end
end
