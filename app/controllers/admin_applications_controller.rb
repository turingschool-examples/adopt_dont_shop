class AdminApplicationsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.associated_pets(params[:id])
    if params[:pet_id].nil?

    else
      @pet_id = (params[:pet_id])
    end
  end
end
