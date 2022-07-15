class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
    end

    def new
        @applicant = Applicant.find(params[:applicant_id])
    end

    def create 
    end
end