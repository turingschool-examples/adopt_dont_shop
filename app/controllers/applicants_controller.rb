class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:id])
        @pets = Pet.search(params[:search])
    end

    def new
    end

    def create 
        applicant = Applicant.new(applicant_params)
        if applicant.save
            redirect_to "/applications/#{applicant.id}" 
        else
            redirect_to "/applications/new"
            flash[:alert] = "Error: #{error_message(applicant.errors)}"
        end
    end

    def update
        @applicant = Applicant.find(params[:id])
        @pet = Pet.search(params[:search])
        @applicant.pets << @pet
        redirect_to "/applications/#{@applicant.id}"
    end
end

private 
    def applicant_params 
        params.permit(:name, :address, :city, :state, :zip, :application_status) #took out, name pets wanted etc added status back in for admin shelters user stories
    end