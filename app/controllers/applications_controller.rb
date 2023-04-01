class ApplicationsController < ApplicationController

  def new
  end

  def show
    @application = Application.find(params[:id])
    @search_results = Pet.search(params[:query])
  end      

  def create
    @application = Application.create_app(application_params)
    if @application
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "Please fill in all fields."
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{application.id}"
  end

  private
   def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
   end
end