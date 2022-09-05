class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new

  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      redirect_to "/applicants/new"
      flash.alert = @applicant.errors.full_messages
      # flash.alert = "Missing Required Info - All Fields must be filled in."
    end
  end

  def update
    applicant = Applicant.find(params[:id])
    
    if params[:pet_id] != nil
      pet = Pet.find(params[:pet_id])
      applicant.pets << pet
    elsif params[:status] != nil
      applicant.update(applicant_params)
    end
    redirect_to "/applicants/#{applicant.id}"
  end

  private

  def applicant_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
  end
end
