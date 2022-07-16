class ApplicantsController < ApplicationController

  def show 
    @applicant = Applicant.find(params[:id])
  end

  def new
  end
end