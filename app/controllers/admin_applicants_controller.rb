class AdminApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.pets
  end

  def update 
    applicant = Applicant.find(params[:id])
    pet_applicant = PetApplicant.find(params[:id])

    if params[:pet_id].present? && params[:applicant_id].present?
      pet_applicant.update(status: 2)
    end
  end
end