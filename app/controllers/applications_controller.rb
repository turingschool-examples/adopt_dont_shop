class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def new
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
  end
end