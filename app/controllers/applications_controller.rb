class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @searched_pets = 
      if params[:search_partial]
        Pet.search(params[:search_partial])
      end
  end

  def new
  end

  def create
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "You must fill out all fields to submit the application"
      redirect_to "/applications/new"
    end
  end

  def update
    require 'pry'; binding.pry
  end

  private

  def app_params
    params.permit(:fname, :lname, :street_address, :city, :state, :zip_code, :good_home_argument, :status)
  end
end