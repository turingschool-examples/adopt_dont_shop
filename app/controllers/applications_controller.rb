class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def index
    @application = Application.all
  end

  def create
    application = Application.new(app_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  private

  def app_params
    if params[:application_status].nil? || params[:application_status].empty?
      params[:application_status] = 'In Progress'
    end
    params.permit(:id, :name, :street, :city, :state, :zip_code, :good_home, :application_status)
  end
end