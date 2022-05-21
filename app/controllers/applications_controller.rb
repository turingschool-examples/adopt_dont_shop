class ApplicationsController < ApplicationController

  def show
    @applications = Application.find(params[:id])
  end

  def index
    @applications = Application.all
  end

end
