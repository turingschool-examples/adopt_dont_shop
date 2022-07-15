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
    app = App.new(app_params)

    if app.save
      redirect_to "/apps/#{app.id}"
    else
      redirect_to "/apps/new"
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end
  end

  private
  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description, :status)
  end
end
