class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    params[:description] = 'Place Holder'
    params[:status] = 'In Progress'
    # require 'pry'; binding.pry
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}" and return
    else
      flash[:notice] = "Error: please enter all required fields."
      redirect_to "/applications/new" and return
    end
  end

  def update
    application = Application.find(params[:application_id])
    application.approved_pet_ids << params[:pet_id].to_i
    application.save
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
