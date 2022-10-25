class AdminApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.pets
    if params[:approve] 
      pet_app = PetApplicant.find_pet_app(params[:approve], @applicant.id)
      pet_app.approved
    end
  end

  def update 
    applicant = Applicant.find(params[:id])
  end 
  
end