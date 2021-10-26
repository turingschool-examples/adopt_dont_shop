class ApplicationPetsController < ApplicationController
  def update
    application_pet = load_application_pet(params[:application_id], params[:pet_id])
    application_pet.update(application_pet_params)
    application = load_application(params[:application_id])

    application.check_status

    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private

    def application_pet_params
      params.permit(:pet_id, :application_id, :state)
    end

    def load_application_pet(a_id, p_id)
      ApplicationPet.where(pet_id: p_id, application_id: a_id)
    end

    def load_application(id)
      Application.find(id)
    end
end
