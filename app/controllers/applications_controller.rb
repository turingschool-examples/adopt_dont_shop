class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.create(application_params)
    # if application.save
      redirect_to "/applications/#{application.id}"
    # else
    #   redirect_to '/applications/new'
    #   flash[:notice] = "Error! Required information missing!"
    # end
  end

private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end

end
