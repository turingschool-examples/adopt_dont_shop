class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
        binding.pry
    end
    
end