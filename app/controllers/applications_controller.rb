class ApplicationsController < ApplicationController
  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] = 'Fill out this feild.'
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end

  def update
    application = Application.find(params[:id])
    application.update(status: 'Pending', description: params[:description])
    redirect_to "/applications/#{application.id}"
  end
end
