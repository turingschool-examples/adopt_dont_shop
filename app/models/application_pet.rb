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

  def approved?
    if ApplicationPet.where(application_id: self.application.id).uniq.pluck(:status).all? == true
      self.application.update(status: "Approved")
    else
      "Denied"
    end
  end
end