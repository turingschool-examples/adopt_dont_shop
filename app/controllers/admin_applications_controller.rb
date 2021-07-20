class AdminApplicationsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.associated_pets(params[:id])
    @pet_applications = {}
    @pets.each do |pet|
      @pet_applications[pet.id] = PetApplicant.find_by_parents(pet.id, params[:id]).status
    end
  end

  def update
    pet_application = PetApplicant.find_by_parents(params[:pet_id], params[:id])
    pet_application.update(status: params[:status])

    redirect_to "/admin/applications/#{params[:id]}"
  end
end
