class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
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

  private

  def applicant_params
  #  params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
   begin
    params.require(:first_name)
    params.require(:last_name)
    params.require(:street_address)
    params.require(:city)
    params.require(:state)
    params.require(:zip)
    params.require(:description)
   rescue #ActionController::ParameterMissing
      return
   end

    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
  end
end
