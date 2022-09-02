class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end

  def new

  end

  def create
    @applicant = Applicant.create!(app_params)
  end

private
  def app_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end