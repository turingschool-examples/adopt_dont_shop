class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pet_search = Pet.search(params[:search]) if params[:search].present?
  end

  def new
  end

  def create
    if Applicant.create(applicant_params).valid?
      applicant = Applicant.create(applicant_params)
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to "/applicants/new"
      flash[:message] = "Please fill in all the required fields"
    end
  end

  private

  def applicant_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :description,
                  )
  end
end
