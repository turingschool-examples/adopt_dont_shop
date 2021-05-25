class AdminApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:id])
    @application.evaluate_status
    @pets_adopting = @application.pets
  end

  def update
    #should this all live here or in the application? And here or in the model?
    applicationpet = ApplicationPet.find_record(params[:pet_id], params[:id])
    if params[:outcome] == 'approve'
      applicationpet.update(status: 'Approved')
    else
      applicationpet.update(status: 'Rejected')
    end
    applicationpet.save
    redirect_to action: "show", id: params[:id]
  end
end