class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    if !params[:pet_search].blank?
      @pets = Pet.where(name: "#{params[:pet_search]}")
      binding.pry
    else
      
    end
  end

  def new

  end

  def create
    @applicant = Applicant.create!(app_params)
    redirect_to "/applicants/#{@applicant.id}"
  end

private
  def app_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
