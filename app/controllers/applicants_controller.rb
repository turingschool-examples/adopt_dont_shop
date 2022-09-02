class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
    if params[:description].present?
      @applicant.description = params[:description]
      @applicant.status = "Pending"
      @applicant.save
    end
    @applicant
  end
end