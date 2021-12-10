class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @applicant = Application.find(params[:id])
  end

  private
  def application_params
    params.require(:application).permit(:name, :description, address: [:street, :city, :state, :zip])
  end
end
