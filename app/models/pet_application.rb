class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def update_to(update)
    self.status = update
    self.save
  end
end