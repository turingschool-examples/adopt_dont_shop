class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    application_new = Application.create(app_params)
    redirect_to "/applications/#{application_new.id}"
  end

  private
    def app_params
      params.permit(:name, :city, :address, :state, :zipcode, :rationale, :status)
    end
end
