class ApplicationPetsController < ApplicationController
  def update
    application_pet = load_application_pet(params[:application_id], params[:pet_id])
    #
    if application_pet_params[:state] == "Approved"
      application_pet.approve
    elsif application_pet_params[:state] == "Rejected"
      application_pet.reject
    end

    application = load_application(params[:application_id])
    application.check_status

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private

    def application_pet_params
      params.permit(:pet_id, :application_id, :state)
    end

    def load_application_pet(a_id, p_id)
      ApplicationPet.find_by(application_id: a_id, pet_id: p_id)
    end

    def load_application(id)
      Application.find(id)
    end
end
