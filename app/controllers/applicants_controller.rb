class ApplicantsController < ApplicationController
  def new

  end

  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to "/applicants/new"
      flash[:notice] = "Application not created: #{error_message(applicant.errors)}."
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  private

  def applicant_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
end
