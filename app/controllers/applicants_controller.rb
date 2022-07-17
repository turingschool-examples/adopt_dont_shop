class ApplicantsController < ApplicationController

  def show
     @applicant = Applicant.find(params[:id])
      if params[:pet_name]
        @pets = Pet.search(params[:pet_name])
      else
        @pets =[]
    end
  end

  def new
  end

  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
    flash[:alert] = "Error: #{error_message(applicant.errors)}"
      redirect_to '/applicants/new'
    end
  end
 
  private
  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end
