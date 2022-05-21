class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    new_app = Application.new(app_params)
      if new_app.save
        redirect_to "/applications/#{new_app.id}"
      else
        flash[:notice] = "Application not created: Required information missing"
        redirect_to "/applications/new"
     end
  end

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :status, :description)
  end
end
