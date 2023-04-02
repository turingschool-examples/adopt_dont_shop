class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def change_condition(condition_change)
    self.condition = condition_change
    self.save
  end
end