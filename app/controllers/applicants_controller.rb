class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
    end

    def new
        @applicant = Applicant.find(params[:applicant_id])
    end

    def create 
        redirect_to "/applications/#{[:applicant_id]}/new"
    end
end