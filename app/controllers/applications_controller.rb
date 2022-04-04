class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @pets = @application.pets
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  def update
    # Application.pets << Pet.where("id = #{params[:id]}")
  end

  private

  def application_params
    params.permit :name, :street_address, :city, :state, :zip_code, :description, :status, :pets
  end
end
