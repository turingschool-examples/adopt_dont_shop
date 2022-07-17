class Admin::AppsController < ApplicationController

  def show
    @app = App.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    elsif app_params[:status] == "in progress"
      @pets = Pet.adoptable
    elsif app_params[:status] == "pending"
      @pets = @app.pets
    end
  end

  private
  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description, :status)
  end
end
