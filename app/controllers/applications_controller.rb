class ApplicationsController < ApplicationController 
  
  def index
    @applications = Application.all
  end

  def new 
  end

  def create
    @application = Application.create(app_params)
  end

  def show
    @application = Application.find(params[:id])

    redirect_to "/applications/#{@application.id}"
  end

  private  
    def app_params
      params.permit(:name, :street_address, :city, :state, 
                    :zip_code, :description)
    end
end
