class ApplicationsController < ApplicationController
  def welcome
  end

  def show
    # @pet = Pet.find(params[:id])
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
  end

  def new
    # @application = Application.new(application_params)
  end

  def create
    @app = Application.new(application_params)
    # require 'pry'; binding.pry
    # require 'pry'; binding.pry
      if @app.valid?
        @app.status = "In Progress"
        @app.update(application_params)
        @app.save
        # require 'pry'; binding.pry
        redirect_to "/applications/#{@app.id}"
      else
        flash[:error] = @app.errors.full_messages.join(", ")
        redirect_to "/applications/new"
      end
  end

  private
  
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason_for_adoption, :status)
  end
end
