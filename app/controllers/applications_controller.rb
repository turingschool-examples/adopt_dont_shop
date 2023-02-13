class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if @application.in_progress?
      if params[:pet_search]
        @pets = Pet.search(params[:pet_search])
      else
        @pets = []
      end
    end
  end

  def new
  end

  def create
    new_app = Application.new(app_params)
    if new_app.valid?
      new_app.save!
      new_app.update_status
      redirect_to "/applications/#{new_app.id}"
    else 
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(new_app.errors)}"
    end
  end

  def update
    app = Application.find(params[:id])
    app.update(description: params[:justification])
    app.update_status
    redirect_to "/applications/#{app.id}"
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status, :pet_search)
  end
end