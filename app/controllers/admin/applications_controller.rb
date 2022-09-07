class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = Pet.application_status_pet_name(@application.id)
  end

  def update
    @pet_application = PetApplication.where(pet_id: params[:pet_id], application_id: params[:app_id])
    @application = Application.find(params[:app_id])
      if params[:approve]
        @pet_application.update(application_status: 'Approved')
        
      else
        @pet_application.update(application_status: 'Rejected')
      end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
