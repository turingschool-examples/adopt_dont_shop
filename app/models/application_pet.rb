class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approval_status
    # "Pet Approved" if self.approval
    # "Pet Rejected" if !self.approval
  end
  
end