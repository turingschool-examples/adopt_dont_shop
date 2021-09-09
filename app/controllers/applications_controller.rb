class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search]
     @pet_search = Pet.adoptable.search("%#{params[:search]}%")
   else
     @pets = []
   end
  end

  def index
    @applications = Application.all
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(app_params)
    redirect_to "/applications/#{@application.id}"
  end

  def submit
   @application = Application.find(params[:id])
   @application.description = params[:description]
   @application.status = "Pending"
   @application.save
   redirect_to "/applications/#{@application.id}"
 end
 
  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  def app_params
    params.permit(:name, :street_address, :city, :state, :status, :description)
  end
end
