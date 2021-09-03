class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = current_application
    if params[:name]
      @pets = Pet.search_for(params[:name])
    end
  end

  def new
    @application = Application.new
  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      flash[:success] = 'Application Submitted!'
      redirect_to application_path(new_app.id)
    else
      flash[:alert] = 'Incomplete Application'
      redirect_to new_application_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def application_params
    params.require(:application).permit(:name, :address, :city, :state, :zipcode, :reason)
  end

  def current_application
    Application.find(params[:id])
  end
end
