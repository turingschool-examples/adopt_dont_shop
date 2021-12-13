class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    end

    @selected_pets = @application.pets
    if params[:description]
      @application.update({description: params[:description]})
      @application.save
    end
    @application.update_status
  end

  def new

  end

  def create
    application = Application.create(application_params)

      if application.save
        redirect_to "/applications/#{application.id}"
      else
        flash[:alert] = "Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Description can't be blank"
        redirect_to "/applications/new"
      end
  end

  private

    def application_params
      params.permit(:name, :address, :city, :state, :zip, :description)
    end

end
