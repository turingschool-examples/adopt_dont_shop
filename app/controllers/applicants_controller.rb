class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
  end

  def apply
  end


end
