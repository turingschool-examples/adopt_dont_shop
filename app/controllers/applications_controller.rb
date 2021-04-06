class ApplicationsController < ApplicationController
  def index
    @applications = Applications.all
  end

  def show
    @applications = Application.find(params[:id])
  end

  
end
