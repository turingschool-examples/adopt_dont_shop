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
    if applicant_params == nil
      redirect_to "/applicants/new"
      flash.alert = "Missing Required Info"
    else
      @applicant = Applicant.create!(applicant_params)
      redirect_to "/applicants/#{@applicant.id}"
    end
  end

  def update
    applicant = Applicant.find(params[:id])
    
    # require "pry"; binding.pry
    if params[:pet_id] != nil
      pet = Pet.find(params[:pet_id])
      applicant.pets << pet
    elsif params[:status] != nil
      applicant.update({status: params[:status], description: params[:description]})
    end
    redirect_to "/applicants/#{applicant.id}"
  end

  private

  def applicant_params
   begin
    params.require(:first_name)
    params.require(:last_name)
    params.require(:street_address)
    params.require(:city)
    params.require(:state)
    params.require(:zip)
    params.require(:description)
   rescue
      return
   end

    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
  end
end
