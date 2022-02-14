class ApplicationsController < ApplicationController

 def index
   @applications = Application.all
 end

  def new
  end

  def status
  end

  def create
    new_app = Application.new(application_params)

    if new_app.save
    redirect_to "/applications/#{new_app.id}"
  else
    redirect_to '/applications/new'
    flash[:alert] = "Error: #{error_message(new_app.errors)}"
  end
  end

  def update
    app = Application.find(params[:id])
    app.update(application_params)
      redirect_to "/applications/#{app.id}"
  end


  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  private
  def application_params
    params.permit(:id, :first_name, :last_name, :street_address, :city, :post_code, :good_owner)
  end

end
