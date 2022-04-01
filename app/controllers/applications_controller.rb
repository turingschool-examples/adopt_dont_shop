class ApplicationsController < ApplicationController


  def new 
    @application = Application.new
  end

  def create
    application = Application.create(app_params)
    redirect_to "/applications/#{application.id}"
  end

  def show
    @application = Application.find(params[:id])
  end 



private

  def app_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zipcode)
  end
end
