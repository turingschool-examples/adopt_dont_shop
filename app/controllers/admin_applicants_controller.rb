class AdminApplicantsController < ApplicationController
  def index
    @applications = PetApplicant.order(:created_at)
  end
  
  def show
    @application = Applicant.find(params[:id])
    @pets = @application.pets
  end

  def update
    pet_app = PetApplicant.where(applicant_id: params[:id], pet_id: params[:pet]).first
    if !params[:reject].present?
      new_pet_app_status = pet_app.update(status: "Accepted")
      redirect_to "/admin/applicants/#{params[:id]}"
    else #params[:reject].present?
      new_pet_app_status = pet_app.update(status: "Rejected")
      redirect_to "/admin/applicants/#{params[:id]}"
    end
  end
end