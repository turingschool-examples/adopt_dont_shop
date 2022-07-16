class ApplicantsController < ApplicationController

  def new

  end

  def show
    @applicant = Applicant.find(params[:id])
    if params[:pet_name]
      @new_pets = Pet.pet_search(params[:pet_name])
    end
  end
end
