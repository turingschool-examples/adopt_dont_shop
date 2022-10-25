class AdminApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.pets
    if params[:approve] 
      pet_app = PetApplicant.find_pet_app(params[:approve], @applicant.id)
      pet_app.approved
    elsif params[:reject] 
      rej_pet_app = PetApplicant.find_pet_app(params[:reject], @applicant.id)
      rej_pet_app.rejected
    end
  end

  def update 
    applicant = Applicant.find(params[:id])
  end 
  
end