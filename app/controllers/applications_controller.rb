class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    unless params[:pet_name].nil?
      @pets = Pet.search(params[:pet_name])
    end
  end

  def new; end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = 'Please provide a response for all fields.'
    end
  end

  def update
    application = Application.find(params[:id])
    unless params[:pet_adopt].nil?
      pet = Pet.find(params[:pet_adopt])
      pet_application = PetApplication.create!(application_id: application.id, pet_id: pet.id)
    end
    application.update_attributes(description: params[:description], status: 'Pending') unless params[:description].nil?
    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city,
                  :state, :zipcode, :description, :status)
  end
end
