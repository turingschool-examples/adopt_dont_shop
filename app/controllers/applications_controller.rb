class ApplicationsController < ApplicationController

  def new

  end

  def create
      @application = Application.create!(application_params)
      # if @application.save
        redirect_to "/applications/#{@application.id}"
      # else
      #   redirect_to '/applications/new'
        # flash[:alert] = "Error: #{error_message(.errors)}"
      # end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end


  private

  def application_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :description)
  end


end
