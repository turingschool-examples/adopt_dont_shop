class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approve
    self.update(state: 'Approved')
  end

  def reject
    self.update(state: 'Rejected')
  end
end
