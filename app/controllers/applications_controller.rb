class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @pets = []
      # @pets << @search_results
    end
  end

  def new
  end

  def create
    application_new = Application.create(app_params)

    if application_new.save
      redirect_to "/applications/#{application_new.id}"
    else
      flash[:error] = "Error: Please fill out all fields"
      render :new
    end
  end

  private
    def app_params
      params.permit(:name, :city, :address, :state, :zipcode, :rationale, :status)
    end
end
