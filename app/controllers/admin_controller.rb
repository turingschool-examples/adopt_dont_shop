class AdminController < ApplicationController

  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @pending_shelter_apps = Shelter.joins(pets: [{ pet_applications: :application }]).where('applications.status' == "Pending")
  end
end

#shelter joins pet where shelter.id = pet.shelter_id 
  # joins pet to pet application where pet.id is = pet_application.pet_id

