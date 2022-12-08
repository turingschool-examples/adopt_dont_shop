class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = Pet.pluck(:name)
  end
end