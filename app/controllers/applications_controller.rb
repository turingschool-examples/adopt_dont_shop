class ApplicationsController < ApplicationController
  def show
    if params[:search_for_pet_by_name]
      Pet.find_pet_by_name(params[:search_for_pet_by_name])
    else
    @app = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.new(app_params)

    if app.save
      redirect_to "/applications/#{app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error, please fill out form"
    end
  end

  private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :description, :app_status)
  end
end
