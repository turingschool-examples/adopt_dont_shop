class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # binding.pry
    @pets = @application.pets
  end

  def update
    application_pet = ApplicationPet.find_by(pet_id: admin_application_params[:pet_id], application_id: admin_application_params[:id])
    # binding.pry
    if admin_application_params[:status] == 'Approved'
      application_pet.update(status: 'Approved')
    # else
    #   application_pet.update(status: 'Rejected')
    end
    # binding.pry
    redirect_to "/admin/applications/#{application_pet.application.id}"
    # redirect_to "/admin/applications/#{@application_id}"
  end

  private
  def admin_application_params
    params.permit(:id, :pet_id, :status)
  end
end