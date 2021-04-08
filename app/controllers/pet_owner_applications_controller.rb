class PetApplicationsController < ApplicationController

  private
  def pet_owner_application_params
    defaults = {approved_status: 'N/A'}
    params.permit(:pets_id, :owner_applications_id, :approved_status)
  end

end
