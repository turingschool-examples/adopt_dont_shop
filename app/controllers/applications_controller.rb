class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    ApplicationPet.create(pet_id: params[:pet_id], application_id: params[:id], approved: false)
    @adopt_me = @application.pets
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
    if params[:form]
      @message = "Please fill out all fields!"
    end
  end

  def create
    if params.values.any?("")
      redirect_to "/applications/new?form=unfilled"
    else
      application = Application.create!(application_params)
      redirect_to "/applications/#{application.id}"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(description: params[:description], status:params[:status])
    redirect_to "/applications/#{@application.id}"

  end

  def application_params
    params.permit(:name, :city, :zip, :street, :status, :state, :description)
  end
end
