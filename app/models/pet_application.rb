class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  validates :condition, inclusion: { in: ["Pending", "Approved", "Denied"] }

  def change_condition(condition_change)
    self.condition = condition_change
    self.save
  end
end