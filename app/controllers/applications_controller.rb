class ApplicationsController < ApplicationController 
  def show 
    @application = Application.find(params[:id])
  end

  def new  
  end

  def create 
    application = Application.new(application_params)
    application.save 
    if application.invalid? 
      redirect_to "/applications/new", notice: "Please fill missing fields"
    end
  end
private 
  def application_params 
    params.permit(:applicant, :street, :city, :state, :zipcode, :reason, :status)
  end
end