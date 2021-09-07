class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.search(params[:pet_name])
    end
end

  def new
  end

  def create
    application = Application.new(app_params)

    if application.save
      flash[:submitted] = 'Application Submitted!'
      redirect_to "/applications/#{application.id}"
    else
      flash[:incomplete] = 'All * fields must be filled in'
      redirect_to "/applications/new"
    end
  end

  private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
end
