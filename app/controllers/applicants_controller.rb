class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:id])
    end

    def new
    end

    def create 
        applicant = Applicant.create!(applicant_params)
        # applicant.submit
        redirect_to "/applications/#{applicant.id}" #this needs fixing
    end
end

private 
    def applicant_params 
        params.permit(:name, :address, :city, :state, :zip) #took out description, name pets wanted etc
    end