class AdminApplicantsController < ApplicationController
  def show
    @application = Applicant.find(params[:id])
    @pets = @application.pets
  end
end