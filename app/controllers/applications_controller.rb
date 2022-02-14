class ApplicationsController < ApplicationController
  def index

  end

  def new

  end

  def show
    @application = Application.find(params[:id])
  end

  private
    def application_params
      params.permit(:name, :address, :city, :state, :zipcode, :description)
    end

end
