class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @admin = params[:admin]
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else 
      @pets = Pet.adoptable
    end
  end

  def new
  end

  def create
    app = Application.new(application_params)

    if app.save
      redirect_to "/applications/#{app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end 
  end

  def submit
    app = Application.find(params[:id])
    app.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{app.id}"
  end

  def update
    app = Application.find(params[:id])
    pet_application = app.pet_applications.find_by(pet_id: params[:pet_id].to_i)
    pet_application.update(pet_status: params[:pet_status])
    redirect_to "/admin/applications/#{app.id}"
  end

  def admin
    redirect_to "/applications/#{params[:id]}?admin=true"
  end
  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
