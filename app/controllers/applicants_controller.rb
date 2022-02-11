class ApplicantsController < ApplicationController
  def index
    @applicant = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
    @applicant = Applicant.new
  end

  def create
    app_params
    applicant = Applicant.create!(app_params)
    redirect_to "/applicants/#{applicant.id}"
  end

  def app_params
    params.require(:applicant).permit(:name, :address_line_1, :city, :state, :zipcode, :description, :status)
  end
end
