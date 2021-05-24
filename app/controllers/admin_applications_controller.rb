class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets_adopting = @application.pets
  end

  def update
    #should this all live here or in the application?
    application = Application.find(params[:id])
    if params[:outcome] == 'approve'
      application.update(status: 'Approved')
    else
      application.update(status: 'Rejected')
    end
    application.save
    redirect_to action: "show", id: application.id
  end
end