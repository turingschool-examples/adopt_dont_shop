class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_application = PetApplication.where(params[:pet_id], params[:app_id])
  end

  def update
    @pet_application = PetApplication.where(params[:pet_id], params[:app_id])
    @application = Application.find(params[:app_id].to_i)
      if params[:approve]
        @pet_application.update(application_status: params['Approved'])
        @application.update(status: params['Approved'])

      else
        application.update(status: params['Rejected'])
      end
      @application.save
      @pet_application.save
      redirect_to "/admin/applications/#{@application.id}"
  end

end
