class OwnerApplicationsController < ApplicationController

  def show
    @application = OwnerApplication.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
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

  private
  def owner_application_params
    defaults = {status: 'In Progress'}
    params.permit(:name, :address, :city, :state, :zip, :description)
  end
end
