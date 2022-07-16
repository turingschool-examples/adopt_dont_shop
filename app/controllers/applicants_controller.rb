class ApplicantsController < ApplicationController

  def new

  end

  def show
    @applicant = Applicant.find(params[:id])
  end
end
