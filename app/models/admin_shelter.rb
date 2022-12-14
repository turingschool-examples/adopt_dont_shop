class AdminShelter < ApplicationRecord
  def pending_applications
    Shelter.pending_applications
  end

  # def status

  # end
end