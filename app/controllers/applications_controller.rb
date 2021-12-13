class ApplicationsController < ApplicationController
  def index
  end

  def show
    @application = Application.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    end

    # if params[:description]
    #   @application.update({description: params[description]})
    #   @application.save
    # end
    @application.status_update

  end

  def new
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: Name can't be blank, Steet can't be blank, City can't be blank, State can't be blank, Zipcode can't be blank"
      redirect_to "/applications/new"
    end
  end


  def update

    application = Application.all[0]
    application.update(application_params)

    redirect_to "/applications/#{application.id}"
  end

private

  def application_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end
