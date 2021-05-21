class ApplicationsController < ApplicationController 
  
  def index
    @applications = Application.all
  end

  def new
  end

  def create
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private  
    def app_params
      params.permit(:name, :street_address, :city, :state, 
                    :zip_code, :description)
    end
end
