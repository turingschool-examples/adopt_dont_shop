class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
    end
    
end