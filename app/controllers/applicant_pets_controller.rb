class ApplicantPetsController < ApplicationController 
   def create 
      @applicant_pet = ApplicantPet.create!(applicant_pet_params)
      redirect_to "/applications/#{@applicant_pet.applicant_id}"
   end

private 
   def applicant_pet_params 
      params.permit(:applicant_id, :pet_id)
   end
end