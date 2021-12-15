class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:adopt]
      ApplicationPet.create!(pet_id: params[:adopt], application_id: @application.id)
    end
    if params[:commit]
      # require 'pry'; binding.pry
      # ApplicationPet.save(pet_id: params[:adopt], application_id: @application.id)
      @application.status = "Pending"
    end
    if params[:search_pets]
      @pets = Pet.search(params[:search_pets])
    else
      @pets = []
    end
  end

  def admin_show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update

  end

  def admin_update
    pet = Pet.find(params[:pet_id])
    pet.update(:adoption_status => params[:approved])
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip, :description)
  end
end
