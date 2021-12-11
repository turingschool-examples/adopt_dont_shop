class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet = .find(params[:id])
  end
end
