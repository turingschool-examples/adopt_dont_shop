class ApplicationsController < ApplicationController

  def new
  end

  def create
  end

  def show
    @application = Application.find(params[:id])
  end

end