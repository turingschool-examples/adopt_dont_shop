class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets_found = Pet.search(params[:pet_of_interst_name])
    @pets = @application.pets
    PetApplication.where({application_id: params[:id]})
    # binding.pry
  end

  def approve
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_approved = Pet.find(params[:pet_id])
    @application.update(status: "Approved")
    @application.save
    @pet_approved.update(adoptable: false)
    @pet_approved.save
    @pet_applications = PetApplication.where({application_id: params[:id]})
    redirect_to "/admin/applications/#{@application.id}"
  end

  def reject
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_approved = Pet.find(params[:pet_id])
    @application.update(status: "Rejected")
    @application.save
    PetApplication.where({pet_id: params[:pet_id], application_id: params[:id]}).update_all(was_approved: false)
    redirect_to "/admin/applications/#{@application.id}"
  end
end
