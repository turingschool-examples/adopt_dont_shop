class ApplicationsController < ApplicationController 
  
  def new 
  end

  def create
    @application = Application.create(app_params)
  end

  private  
    def app_params
      params.permit(:name, :street_address, :city, :state, 
                    :zip_code, :description)
    end
end
