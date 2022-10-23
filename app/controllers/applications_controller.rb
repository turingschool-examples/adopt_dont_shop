class ApplicationsController < ApplicationController 
  def show 
    @application = Application.find(params[:id])
    
    if params[:search].present?
      # binding.pry
      @pets = Pet.search(params[:search])
    else 
      @pets = []
    end
  end

  def new  
  end

  def create 
    application = Application.new(application_params)
    application.save 
    if application.invalid? 
      redirect_to "/applications/new", alert: "Please fill missing fields"
    end
    redirect_to "/applications/#{application.id}"
  end
private 
  def application_params 
    params.permit(:applicant, :street, :city, :state, :zipcode, :reason, :status)
  end
end