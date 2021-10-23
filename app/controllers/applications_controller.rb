class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "All fields must be completed before submission"
      render :new
    end
  end

  private

    def app_params
      params.permit(:name, :street_address, :city, :state, :zip_code)
    end
end
