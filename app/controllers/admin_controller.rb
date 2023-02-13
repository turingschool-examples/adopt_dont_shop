class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_reverse
    @pending_shelters = Shelter.with_pending
  end

  def applications_show
    @application = Application.find(params[:id])
  end

  def applications_update
    @petapplication = PetApplication.find(params[:pet_application_id])
    @petapplication.update(application_id: params[:id], pet_id: params[:petid], status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
