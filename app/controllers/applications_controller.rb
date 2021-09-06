class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
  end

  def new 
  end

  def create
    @application = Application.new(app_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "The one who fills out all the fields, has the greatest chance of getting a pet!"
    end
  end

  private
  def app_params
    params.permit(:name, :street, :city, :state, :zip, :description)
  end
end