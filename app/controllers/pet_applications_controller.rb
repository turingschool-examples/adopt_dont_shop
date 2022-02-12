class PetApplicationsController < ApplicationController
  def create
    applicant = Applicant.find(params[:applicant_id])
    pet = Pet.find(params[:pet_id])
    PetApplication.create!(applicant: applicant, pet: pet)
    redirect_to("/applicants/#{params[:applicant_id]}")
  end
end
