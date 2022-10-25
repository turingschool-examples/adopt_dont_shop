class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_pending_applications = Pet.with_pending_applications
  end

  def show 
    @applicant = Applicant.find(params[:id])
    @petapplicant = PetApplicant.where(pet_id: params[:pet_id]).where(applicant_id: params[:id])
  
  end
  
  def update 
    @petapplicant = PetApplicant.where(pet_id: params[:pet_id]).where(applicant_id: params[:id])
    @petapplicant.update(status: params[:status])
    @applicant = Applicant.find(params[:id])
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

end