class AppsController < ApplicationController
  def show
    @app = App.find(app_params[:id])
    if search_params[:name]
      @pet_search = Pet.search(search_params[:name])
    end
  end

  def new
    @app_params = app_params
  end

  def create
    app = App.new(app_params)
    if app.save
      redirect_to "/apps/#{app.id}"
    else
      @app_params = app_params
      flash[:alert] = "Error: #{error_message(app.errors)}"
      render "/apps/new"
    end
  end

  def update
    params[:status] = 1
    app = App.find(app_params[:id])
    app.update(app_params)
    redirect_to "/apps/#{app.id}"
  end

  private
  def app_params
    params.permit(:id, :description, :status, :name, :street, :city, :state, :zip)
  end
  def search_params
    params.permit(:name)
  end
end