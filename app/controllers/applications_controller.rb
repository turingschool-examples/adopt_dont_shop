class ApplicationsController < ApplicationController 

  def new
  end

  def create 
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  # def create
  #   application = Ppplication.new(application_params)

  #   if application.save
  #     redirect_to "/application/#{application.id}"
  #   else
  #     redirect_to "/applications/new"
  #     flash[:alert] = "Error: #{error_message(application.errors)}"
  #   end
  # end


  private 
     
    def application_params 
      params.permit(:name, :street_address, :city, :state, :zip_code, :description)
    end
end