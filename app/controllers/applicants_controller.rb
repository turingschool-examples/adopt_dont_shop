class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:applicant_id])
    end

    def new
        # @applicant = Applicant.new
        # @applicant.id = (params[:applicant_id])
    end

    def create 
        Applicant.create(applicant_params)
        # applicant.submit
        redirect_to "/applications" #this needs fixing
    end
end

private 
def applicant_params 
    params.permit(:name, :address, :city, :state, :zip, :description, :names_pets_wanted, :application_status)
end