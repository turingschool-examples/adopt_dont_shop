class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.adoptable.search(params[:search])
    end
  end

  def new  
  end

  def create
    application = Application.new(application_params)
    if application.save
      application.update(status: "In Progress")
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet_id] 
      @pet = Pet.find(params[:pet_id])
      @application.pets << @pet
    elsif params[:home_description]
      @application.update(home_description: params[:home_description])
      @application.update(status: "Pending")
    end 
    redirect_to "/applications/#{@application.id}"
  end 
  
private
  def application_params
    params.permit(:first_name, :last_name, :str_address, :city, :state, :zip, :home_description, :status)
  end
end