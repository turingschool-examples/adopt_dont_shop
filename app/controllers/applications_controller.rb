class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search_pets]
      @pets = Pet.search_adoptable_pets(params[:search_pets])
    end
  end

  def new
  end

  def create
    if app_params.values.any?("")
      redirect_to '/applications/new?missing_field=true'
    else
      new_app = Application.create(app_params)
      redirect_to "/applications/#{new_app.id}"
    end
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason, :status)
  end
end


