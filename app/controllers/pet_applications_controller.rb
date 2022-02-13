class PetApplicationsController <  ApplicationController
  def create
    PetApplication.create(pet_app_params)
    redirect_to("/applications/#{params[:application_id]}")
  end

  private
    def pet_app_params
      params.permit(:pet_id, :application_id, :status)
    end
end
