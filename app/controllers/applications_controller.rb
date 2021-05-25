class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
    )
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Application not saved: Please fill in missing fields."
      redirect_to "/applications/new" #render does not work here, why?
    end
  end
end
