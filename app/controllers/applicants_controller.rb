class ApplicantsController < ApplicationController
 def index
   @applicants = Applicant.all
 end

 def show
   @applicant = Applicant.find(params[:id])
 end
end
