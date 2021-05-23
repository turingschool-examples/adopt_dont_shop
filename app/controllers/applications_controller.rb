class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:pet_of_interst_name])
  end

  def new
    # @application = Application.find(params[:id])
  end

  def create
    application = Application.create(applications_params)
    redirect_to '/applications'
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    application = Application.new(applications_params)
  end

  def destroy
    Application.find(params[:id]).destroy
    redirect_to '/applications'
  end

  private

  def applications_params
    params.permit(:name, :address, :description, :status)
  end
end
