class ApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
  end

  def new

  end 
end
