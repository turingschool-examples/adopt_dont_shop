class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:id])
    end

    def new
    end

    def create 
        applicant = Applicant.new(applicant_params)
        applicant.application_status = "In Progress"
        if applicant.save
            redirect_to "/applications/#{applicant.id}" 
        else
            redirect_to "/applications/new"
            flash[:alert] = "Error: #{error_message(applicant.errors)}"
        end
    end
end

private 
    def applicant_params 
        params.permit(:name, :address, :city, :state, :zip) #took out description, name pets wanted etc
    end