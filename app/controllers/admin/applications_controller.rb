class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:app_id])
    @pet = Pet.find(params[:pet_id])
      if params[:approve]
        @application.update(status: params['Approved'])
        @application.save
        @pet.update(adoptable: params['False'])
        @pet.save
      else
        @application.update(status: params['Rejected'])
        @application.save
      end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
