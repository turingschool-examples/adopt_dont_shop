class ApplicationsController < ApplicationController
  def new; end

  def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] =
        "Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank"
      redirect_to '/applications/new'
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @search_pets = Pet.where(name: params[:pet_name]) if params[:pet_name].present?

    if params[:description]
      @application.update(description: params[:description])
      @application.save
    end

    @application.update_status_pending if @application.description.length > 2
  end

  private

  def application_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :description)
  end
end
