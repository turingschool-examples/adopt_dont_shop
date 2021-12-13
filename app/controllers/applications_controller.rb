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

  def edit
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to "/applications/#{@application.id}"
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
