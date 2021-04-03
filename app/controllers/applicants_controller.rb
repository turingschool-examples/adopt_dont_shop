class ApplicantController < ApplicationController

  def index
    @applicants = Applicant.all
  end

end
