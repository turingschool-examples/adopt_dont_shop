class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:application_id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zip_code}"
    if params[:search].present?
      @pets = Pet.search(params[:search])
    elsif params[:mypet].present?
      mypet = Pet.find(params[:mypet])
      ApplicationPet.create!(application: @application, pet: mypet)
    end
  end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end

  def new
  end

  def create
    new_application = Application.new(application_params)
    if new_application.valid?
      new_application.save
      redirect_to "/applications/#{new_application.id}"
    else 
      redirect_to '/applications/new'
      flash[:incomplete] = "Form cannot be blank"
    end  
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end