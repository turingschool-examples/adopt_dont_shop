class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.where(name: params[:pet_name])
    end
  end

  def new
  end

 def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] =
        "Error: All fields must be completed to submit!"
      redirect_to '/applications/new'
    end
  end


  private

  def application_params
     params.permit(:name, :street_address, :city, :state, :zip_code, :description, :application_status)
    # params.permit(:id, :name, :address, :city, :state, :zipcode, :description)
  end
end
