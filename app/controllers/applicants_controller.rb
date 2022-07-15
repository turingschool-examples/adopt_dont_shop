class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new
    @applicant = Applicant.new
  end

  def edit
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def create
    applicant = Applicant.create!(applicant_params)
  end

  def update
    applicant = Applicant.find(params[:id])
    applicant.update(applicant_params)
    redirect_to
  end

  def destroy
  end

  private

end
