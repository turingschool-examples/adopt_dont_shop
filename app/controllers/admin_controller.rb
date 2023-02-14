class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_reverse
    @pending_shelters = Shelter.with_pending
  end

  def applications_show
    @application = Application.find(params[:id])
  end

  def applications_update
    @application = Application.find(params[:id])
    @petapplication = PetApplication.find(params[:pet_application_id])
    @petapplication.update(application_id: params[:id], pet_id: params[:petid], status: params[:status])
    status_array = @application.pets.map do |pet|
      @application.pet_application_by_pet(pet).status
    end
    unless status_array.include?('Pending')
      if status_array.include?('Rejected')
        @application.update(status: 'Rejected')
      else 
        @application.update(status: 'Approved')
      end
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
