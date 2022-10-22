class ApplicantsController < ApplicationController 

  def index
    @applicants = Applicant.all 

  end

  def show 
    @applicant = Applicant.find(params[:id])
    @pets = Pet.all
    if params[:search_name].present? 
      @pets = Pet.search(params[:search_name])
    else 
      "doesn't work"
    end
     @applicant
  end

  def new 
  end

  def create 
    applicant = Applicant.new(applicant_params)
    if applicant.valid? 
       applicant.update(status: "In Progress")
       redirect_to "/applicants/#{applicant.id}"
    else
      flash[:alert] = "Error: #{error_message(applicant.errors)}"
      redirect_to "/applicants/new"
    end
  end

  private 
  def applicant_params 
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description)
  end
end