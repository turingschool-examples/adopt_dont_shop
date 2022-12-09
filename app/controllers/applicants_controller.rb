class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pet_id_pairs = Pet.pluck(:id, :name)
  end

  def new
  end

  def create
    @applicant = Applicant.create!(applicants_params)
    redirect_to "/applicants/#{@applicant.id}"
  end

  private
  def applicants_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end