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

  def update
    application = Application.find(params[:id])
    if params[:rationale]
      application.update_attribute(:status, "Pending")
      application.update_attribute(:rationale, params[:rationale])
      redirect_to "/applications/#{application.id}?status=pending"
    end
  end

  private
    def app_params
      params.permit(:name, :city, :address, :state, :zipcode, :rationale, :status)
    end
end
