class ApplicantsController < ApplicationController
 def index
   require "pry"; binding.pry
   @applicants = Applicant.all
 end

 def show
   @applicant = Applicant.find(params[:id])
 end
end
