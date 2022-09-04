class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    if params[:pet_search].present?
      @pets = Pet.search(params[:pet_search])
    end
  end

  def new

  end

  def create
    applicant = Applicant.create(app_params)
    if applicant.save
      flash.clear
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to "/applicants/new"
      flash[:alert] = "Please Enter Data For Each Field"
    end
  end

private
  def app_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
