class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new

  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new", alert: "Application not created: Required information missing"
    end
  end

  def update
    application = Application.find(params[:id])
    if params[:pet_id].present?
      ApplicationPet.create!(application: application, pet: Pet.find(params[:pet_id]))
    elsif params[:submit].present?
      application.status = 1
      application.save
    end
    redirect_to "/applications/#{application.id}"
  end


  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end
