class ApplicantsController < ApplicationController
    def show 
      @applicant = Applicant.find(params[:id])
      @pets = Pet.where(name: params[:search])

      if params[:add_pet] != nil
        @applicant.add_pet(params[:add_pet])
      end
    end

    def create
      applicant = Applicant.new(applicant_params)

      if applicant.save
        redirect_to "/applicants/#{applicant.id}"
      else 
        redirect_to "/applicants/new"
        flash[:alert] = "Error: #{error_message(applicant.errors)}"
      end
    end

    def update
      applicant = Applicant.find(params[:id])
      applicant.update(applicant_params)

      redirect_to "/applicants/#{applicant.id}"
    end

    private
    def applicant_params
      params.permit(:name, :street_address, :city, :state, :zip, :good_fit, :status)
    end
end