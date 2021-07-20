class AdminApplicationsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.associated_pets(params[:id])
    if @pet_application.nil?
      @pet_application = PetApplicant.where("applicant_id = ?", params[:id]).limit(1).first
    else

    end
  end

  def update
    @pet_application = PetApplicant.where(["pet_id = ? and applicant_id = ?", params[:pet_id], params[:id]])
    @pet_application.update(status: params[:status])

    redirect_to "/admin/applications/#{params[:id]}"
  end
end
