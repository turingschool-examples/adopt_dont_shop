class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_id_pairs = Pet.pluck(:id, :name)
  end

  def new
  end

  def create
    if(Application.create(applications_params).valid?)
      @application = Application.create!(applications_params)
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new?error=true"
    end
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
