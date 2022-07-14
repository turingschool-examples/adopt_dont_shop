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
    
  end

  private
  def pet_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
end
