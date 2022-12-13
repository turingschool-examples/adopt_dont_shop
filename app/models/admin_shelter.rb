class AdminShelter < ApplicationRecord
  def pending_applications
    Shelter.pending_applications
  end
end