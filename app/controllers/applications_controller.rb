class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @adoptees = @application.pets
    if params[:pet_name] == nil
      @search_pets = []
    else
      @search_pets = Pet.search(params[:pet_name])
    end
  end

  def create
    application = Application.new(create_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:notice] = "Application Not Created, Required Information Missing"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(update_params)

    redirect_to "/applications/#{application.id}"
  end

  private

  def create_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

  def update_params
    params.permit(:description, :status)
  end
end
