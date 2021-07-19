class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def new
    @application = Application.new(application_params)
  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save
      flash[:notice] = "Application Saved Successfully"
      redirect_to "/applications/#{@application.id}/"
    else
      render "new"
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    redirect_to "/applications/#{@application.id}/?submitted=true"
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @found_pets = Pet.find_by_name(params[:search])
    elsif params[:pet_id].present?
      @application.pets << Pet.find(params[:pet_id])
    elsif params[:submitted].present?
      @application = Application.find(params[:id])
    end
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    redirect_to '/applications'
  end

private
  def application_params
    params.permit(:name, :application_status, :street, :city, :state, :zip_code, :description)
  end


end
