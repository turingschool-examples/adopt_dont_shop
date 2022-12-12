class AdminShelter < ApplicationRecord
  def pending_applications
    require 'pry'; binding.pry
    Shelter.pending_applications
  end
end