class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def all_params_present?(params)
    # (params[:name] != nil) and (params[:street_address] != nil) and (params[:city] != nil) and (params[:state] != nil) and (params[:zip_code] != nil)
    (params[:name].present?) and (params[:street_address].present?) and (params[:city].present?) and (params[:state].present?) and (params[:zip_code].present?)
    # params.all?(&:present)
  end

  def create
    if all_params_present?(app_params)
      @application = Application.create(app_params)
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "Please fill out ALL application fields!!!!!"
      redirect_back(fallback_location: "/applications/new")
      # redirect_to "/applications/new"
    end
  end

private
    def app_params
      params.permit(:name, :street_address, :city, :state, :zip_code).merge(description: " ", app_status: "In Progress")
    end


end
