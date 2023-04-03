class AdminController < ApplicationController

  def shelters_index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @pending_shelter_apps = Shelter.joins(pets: [{ pet_applications: :application }]).where('applications.status' == "Pending")
  end

  def applications_show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application.status = 'Pending' if !@application.pet_applications.nil?
    @application.status = 'Approved' if params[:approved] == 'true'
  end
end

#shelter joins pet where shelter.id = pet.shelter_id 
  # joins pet to pet application where pet.id is = pet_application.pet_id

