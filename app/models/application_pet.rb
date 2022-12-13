class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def approval_status
    if status == true
      "Pet Approved"
    elsif status == false
      "Pet Rejected"
    else
      return
    end
  end
end