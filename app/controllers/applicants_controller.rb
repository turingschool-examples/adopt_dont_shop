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
    @applicant = Applicant.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @applicant.pets << @pet
    redirect_to "/applicants/#{@applicant.id}"
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
