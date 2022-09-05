class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pets = @app.list_pets
  end
end