class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
    end

    def new
        # @applicant = Applicant.find(params[:applicant_id])
    end

    def create 
        applicant = Applicant.create(applicant_params)
        applicant.submit
        redirect_to "/applications/#{applicant.id}" #this needs fixing
    end
end

private 
def applicant_params 
    params.permit(:name, :address, :city, :state, :zip, :description)
end