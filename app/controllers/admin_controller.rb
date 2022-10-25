class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_pending_applications = Pet.with_pending_applications
  end

  def show 
    @applicant = Applicant.find(params[:id])
    @petapplicant = PetApplicant.find_petapplicant(params[:id], params[:pet_id])
  
  end
  
  def update 
    @petapplicant = PetApplicant.find_petapplicant(params[:id], params[:pet_id])
    @petapplicant.update(status: params[:status])
    @applicant = Applicant.find(params[:id])
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

end