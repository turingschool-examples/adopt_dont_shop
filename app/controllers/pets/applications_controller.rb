class Pets::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @adoptees = @application.pets
  end
end
