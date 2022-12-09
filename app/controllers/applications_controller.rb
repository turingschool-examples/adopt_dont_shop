class ApplicationsController < ApplicationController
  def show
    @application = Applicant.find(params[:id])
    @pet_id_pairs = Pet.pluck(:id, :name)
  end

  def new
  end

  def create
    @application = Applicant.create!(applications_params)
    redirect_to "/applications/#{@application.id}"
  end

  private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end
