class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
  end

  def new
    if params[:form]
      @message = "Please fill out all fields!"
    end
  end

  def create
    if params.values.any?("")
      redirect_to "/applications/new?form=unfilled"
    else
      application = Application.create!(application_params)
      redirect_to "/applications/#{application.id}"
    end
  end

  def application_params
    params.permit(:name, :city, :zip, :street, :status, :state, :description)
  end
end
