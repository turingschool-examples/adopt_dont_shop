class ApplicantsController < ApplicationController

  def index
    @applicants = Applicant.all 
  end

  def show
    @applicant = Applicant.find(params[:applicant_id])
    if params[:description].present?
      @applicant.description = params[:description]
      @applicant.status = "Pending"
      @applicant.save
    end
    @applicant
  end

  def new
    
  end

  def create
    applicant = Applicant.create(applicant_params)
    if applicant.valid?
      redirect_to "/applicants/#{applicant.id}"
    else
    flash[:notice] = "Unable to create application"
      redirect_to '/applicants/new'
    end 
  end

  private
  def applicant_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end