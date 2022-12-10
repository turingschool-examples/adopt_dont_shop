class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = []
    @pets = Pet.search(params[:name_input]) if params[:name_input]
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  def new
    @application = Application.new(application_params)
  end

  def update
    application = Application.find(params[:application_id])
    application.update(application_params)
    application.update(status: "Pending") if params[:reason]
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason, :status)
  end
end