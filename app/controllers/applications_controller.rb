class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @found_pets = Pet.search(params[:search])
    else
      @found_pets = []
    end
  end

  def index
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:messages] = @application.errors.full_messages
      render :new
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :search)
  end
end