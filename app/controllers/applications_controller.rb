class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    Application.create(application_params)

    new_application = Application.last
    redirect_to "/applications/#{new_application.id}"
  end


  private

  def application_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip_code,
                  :description,
                  :status)
  end
end
