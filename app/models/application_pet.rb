class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve
    ApplicationPet.where(pet_id: self.pet_id).update(state: 'Taken')
    self.update(state: 'Approved')
  end

  def reject
    self.update(state: 'Rejected')
  end
end
