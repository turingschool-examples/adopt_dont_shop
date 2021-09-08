class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.where("lower(name) like ?", "%#{params[:search].downcase}%")
    else
      flash[:alert] = "There is no pet by that name"
      @pets = []
    end
  end 

  def new 
  end

  def create
    @application = Application.new(app_params)
    if @application.save 
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "The person who fills out all the fields, has the greatest chance of getting a pet!"
    end
  end

  private
  def app_params
    params.permit(:name, :street, :city, :state, :zip, :description)
  end
end