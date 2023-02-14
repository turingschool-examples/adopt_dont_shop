class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
    @results = Pet.search(params[:search])
  end

  def new
    
  end

  def create
    @app = Application.new(application_params)
      if @app.valid?
        @app.status = "In Progress"
        @app.update(application_params)
        @app.save
        redirect_to "/applications/#{@app.id}"
      else
        flash[:error] = @app.errors.full_messages.join(", ")
        redirect_to "/applications/new"
      end
  end

  def update
    @applicant = Application.find(params[:id])
    @applicant.update(application_params)
    @applicant.status = "Pending"
    @applicant.save
    redirect_to "/applications/#{@applicant.id}"
  end

  private
  
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason_for_adoption, :status)
  end
end
