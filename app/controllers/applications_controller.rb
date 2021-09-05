class ApplicationsController < ApplicationController
  def new
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = 'Your form is incomplete! Fill it out!!!'
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end

end
