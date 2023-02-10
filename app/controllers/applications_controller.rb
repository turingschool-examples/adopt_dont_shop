class ApplicationsController < ApplicationController
  def show
    @applicant = Application.find(params[:id])
  end
end