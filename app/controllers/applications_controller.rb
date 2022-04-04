class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search]
      @pet_results = Pet.search(params[:search])
    else
      @pet_results = []
    end
  end

  def new
  end

  def create
    params[:description] = 'Place Holder'
    params[:status] = 'In Progress'
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}" and return
    else
      flash[:notice] = "Error: please enter all required fields."
      redirect_to "/applications/new" and return
    end
  end

  def update
    if params[:approval]
      application = Application.find(params[:application_id])
      application.approved_pet_ids << params[:pet_id]
      application.save
      redirect_to "/admin/applications/#{params[:application_id]}"
    elsif params[:rejection]
      application = Application.find(params[:application_id])
      application.rejected_pet_ids << params[:pet_id]
      application.save
      redirect_to "/admin/applications/#{params[:application_id]}"
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
