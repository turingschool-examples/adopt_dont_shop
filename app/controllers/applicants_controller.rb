class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
    @applicant = Applicant.new
  end

  def create
    applicant = Applicant.new(applicant_params)
    applicant.save
    redirect_to "/applicants/#{applicant.id}"
  end

  private
  def applicant_params
    params.permit(:id, :name, :street, :city, :state, :zip, :good_home)  
  end
end