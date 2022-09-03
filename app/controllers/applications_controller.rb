class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  def application_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description)
  end

end
