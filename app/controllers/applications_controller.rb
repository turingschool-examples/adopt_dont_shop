class ApplicationsController < ApplicationController

  def new

  def show
    @application = Application.find(params[:id])
  end
end