class ApplicationsController < ApplicationController
  def new
    @pets = Pet.adoptable
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:notice] = "Application not submitted: Required information missing."
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:query]
      @pet_results = Pet.search(params[:query])
    elsif params[:pet_name]
      PetApplication.associate(params[:pet_name], @application)
    end
  end

  def update
    Application.update(params[:id], :description => params[:description], :status => "Pending")
    redirect_to "/applications/#{params[:id]}"
  end

  private
  def application_params
    params.permit(:id, :name, :street_address, :city, :zipcode, :state, :description, :status, :created_at, :updated_at)
  end
end
