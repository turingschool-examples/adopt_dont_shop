class OwnerApplicationsController < ApplicationController

  def index
    @applications = OwnerApplication.all
  end

  def show
    @application = OwnerApplication.find(params[:id])

    if params[:search].present?
      @pets = []
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    @new_app = OwnerApplication.new(owner_application_params)
    if new_app.save
      flash[:notice] = "Your application was submitted!"
      redirect_to "/owner_applications/#{@new_app.id}"
    else
      flash[:notice] = 'Please fill in all fields'
      render :new
    end
  end

  def update
    if params[:pet_id].present? == false
      @application = OwnerApplication.find(params[:id])
      @application.update(description: params[:description], status: params[:status])
      render :show
    else
      @application = OwnerApplication.find(params[:id])
      PetApplication.create!(application_id: @application.id, pet_id: params[:pet_id])
      render :show
    end
  end

  private
  def owner_application_params
    defaults = {status: 'In Progress'}
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end
