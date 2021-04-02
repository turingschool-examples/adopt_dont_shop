class AdoptingApplicationsController < ApplicationController
  def show
    @applicant = AdoptingApplication.find(params[:id])
  end
end
