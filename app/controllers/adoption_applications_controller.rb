class AdoptionApplicationsController < ApplicationController
  def new
  end

  # def show
  #   @adopt_app = AdoptionApplication.find(params[:id])
  # end

  def create
    adopt_app = AdoptionApplication.create(adopt_app_params)
    redirect_to "/adoption_applications/#{adopt_app.id}"
  end

  private

  def adopt_app_params
    params
      .permit(:name, :street_address, :city, :state, :zip_code, :status)
      .with_defaults(status: 'In Progress')
  end
end
