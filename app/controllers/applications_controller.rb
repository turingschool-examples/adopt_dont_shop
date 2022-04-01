class ApplicationsController < ApplicationController


  def new 
    @application = Application.new
  end

  def create
    application = Application.create(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else 
      redirect_to "/applications/new"
      flash[:alert] = "Error: all requested areas must be filled!"
    end
  end

  def show
    @application = Application.find(params[:id])
  end 



private

  def app_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zipcode, :status)
  end
end
