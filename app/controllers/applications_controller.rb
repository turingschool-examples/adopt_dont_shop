class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets

    if params.include?(:search)
      @pet_results = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    # redirect_to "/applications/#{@application.id}"

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def update
    @application = Application.find(params[:id])
    if @application.status == "Pending"
      redirect_to "/applications/#{@application.id}", alert: "Your application is under review"

    elsif params[:description]
      @application.update(description: params[:description], status: "Pending")
      redirect_to "/applications/#{@application.id}"
    
    elsif params[:pet_id]
      PetApplication.create(pet_id: params[:pet_id], application_id: @application.id)
      redirect_to "/applications/#{@application.id}"
    end
  end

  private

  def application_params
    params.permit(:name,
                  :address,
                  :city,
                  :state,
                  :zip,
                  :description,
                  :status,
                  :search,
                  :pet_id)
  end
end
