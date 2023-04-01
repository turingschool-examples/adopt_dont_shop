class PetApplicantsController < ApplicationController
  def create
    pet_applicant = PetApplicant.create(pet_applicant_params)
    redirect_to "/applicants/#{pet_applicant.applicant_id}"
  end

  private
  def pet_applicant_params
    params.require(:pet_applicant).permit(:applicant_id, :pet_id)
  end
end
