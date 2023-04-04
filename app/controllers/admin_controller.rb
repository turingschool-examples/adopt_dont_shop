class AdminController < ApplicationController

  def shelters_index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @pending_shelter_apps = Shelter.joins(pets: [{ pet_applications: :application }]).where('applications.status' == "Pending")
  end

  def applications_show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application.status = 'Pending' if !@application.pet_applications.nil?
    @pet = @pets.find(params[:approved]) if !params[:approved].nil?
    PetApplication.joins(:pet).where("pet_id = #{@pet.id} and application_id = #{@application.id}").first.update_to('Approved') if !params[:approved].nil?
    PetApplication.joins(:pet).where("pet_id = #{@pet.id} and application_id = #{@application.id}").first.update_to('Rejected') if !params[:rejected].nil?
    @pet_applications = PetApplication.joins(:pet)
  end
end

#shelter joins pet where shelter.id = pet.shelter_id 
  # joins pet to pet application where pet.id is = pet_application.pet_id

