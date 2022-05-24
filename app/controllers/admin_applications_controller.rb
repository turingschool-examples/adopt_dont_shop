class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # require 'pry'; binding.pry
  end

  def update
    pet_application = PetApplication.where(application_id: params[:id], pet_id: params[:pet_id])
    if params[:approved] == "true"
      # require "pry"; binding.pry
      pet_application.update(approved: "true")
    else params[:approved] == "false"
      pet_application.update(approved: "false")
    end
     redirect_to "/admin/applications/#{pet_application.id}"
     # redirect_to "/admin/applications/#{params[:id]}"

     # pet = Application.find(params[:id]).pets.find(params[:pet_id])
    #   pet.pet_applications.where(application_id: params[:id]).first.update(approved: true)
    # else params[:denied].present?
    #   pet.pet_applications.where(application_id: params[:id]).first.update(approved: false)
    # end
    #  redirect_to "/admin/applications/#{pet.pet_applications.first.application_id}"
  end

  private
    def pet_applications_params
      params.permit(:approved)
    end

end
