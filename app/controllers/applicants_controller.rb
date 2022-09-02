class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
  end

  def new

  end

  def create
    @applicant = Applicant.create!(applicant_params)
    redirect_to "/applicants/#{@applicant.id}"
  end

  private

  def applicant_params 
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
  end
end
