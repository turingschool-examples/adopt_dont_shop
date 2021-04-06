class ApplicantsPetsController < ApplicationController
  def show
    @application = ApplicantsPet.find(params[:id])
  end

  def new
  end
end
