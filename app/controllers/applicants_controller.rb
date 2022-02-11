class ApplicantsController < ApplicationController
  def index; end

  def show
    @applicant = Applicant.find(params[:id])
  end
end
