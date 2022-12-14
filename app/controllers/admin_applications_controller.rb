class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(permitted_params[:id])
    @application_pets = @application.pets
  end

  def update
    application_pet = ApplicationPet.find_by(pet_id: permitted_params[:pet_id], application_id: permitted_params[:id])
    if permitted_params[:status] == "Approved"
      
      application_pet.update(status: 'Approved')
    end
    redirect_to "/admin/applications/#{application_pet.application.id}"

    #  require 'pry'; binding.pry
    # if application_pet.status == "Pending"
    #   application_pet.update!(adopted: true)
    #   application = application_pet.application
    #   # require 'pry'; binding.pry
    #   application.update!(status: 'Approved')
    #   pet = application_pet.pet
    #   # require 'pry'; binding.pry
    #   pet.update!(adoptable: false)
    # else
    #   # require 'pry'; binding.pry
    #   application.update!(status: 'Rejected')
    #   pet = application_pet.pet
    #   redirect_to "/admin/applications/#{application_pet.application.id}"
    # end
  end

  private
  def permitted_params
    params.permit(:id, :pet_id, :status)
  end
end
