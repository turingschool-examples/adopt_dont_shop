class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if @application.in_progress?
      @pets = Pet.search(params[:pet_search])
    end
  end

  def new

  end

  def create
    @new_app = Application.new(app_params)
    if @new_app.valid?
      @new_app.save
      redirect_to "/applications/#{@new_app.id}"
    else 
      flash.now[:messages] = @new_app.errors.full_messages
      render :new
    end
  end

  private
  
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status, :pet_search)
  end
end