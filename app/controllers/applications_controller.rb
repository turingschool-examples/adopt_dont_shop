class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.create(name: params[:name],
                                      full_address: (params[:street_address] + ", " + params[:city] + ", " + params[:state] + " " + params[:zip_code]),
                                      app_status: "In Progress",
                                      description: " ")
    redirect_to "/applications/#{@application.id}"
  end

end
