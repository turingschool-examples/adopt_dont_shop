class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill out necessary fields for submission"
      redirect_to '/applications/new'
      # render :new
    end
  end

  private

  def application_params
    params.permit(
      :first_name,
      :middle_name,
      :last_name,
      :street_number,
      :street_prefix,
      :street_name,
      :street_type,
      :city,
      :state,
      :zip_code,
      :description,
      :status
    )
  end
end
