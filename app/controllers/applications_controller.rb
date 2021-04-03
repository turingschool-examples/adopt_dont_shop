class ApplicationsController < ApplicationController
  def index
  end

  def show
    @applicant = Application.find(params[:id])
  end

  def new
    @application = Application.new 
  end
end
