class PetApplicantsController < ApplicationController

  def create
    pet = PetApplicant.create!(pet_id:params[:pet], applicant_id: params[:id])
    redirect_to "/applicants/#{params[:id]}"
  end

end