class AppsController < ApplicationController
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
  end

  def create
    app = App.create(app_params)
    # PetApp.create!(pet: params[:pet], app: app)
    redirect_to "/apps/#{app.id}"
  end

  private
  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description, :status)
  end
end
