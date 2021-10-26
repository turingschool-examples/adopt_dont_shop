class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets_found = Pet.adoptable.search_for(params)
  end

  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "All fields must be completed before submission"
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.pets << Pet.find(params[:pets_id])
    redirect_to "/applications/#{@application.id}"
  end

  private

    def app_params
      if params[:status] == nil || params[:status] == ""
        params[:status] = 'In Progress'
      end
      params.permit(:name, :street_address, :city, :state, :zip_code, :status)
    end
end
