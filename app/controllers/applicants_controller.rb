class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
  end

  def create
    @applicant = Applicant.create!(applicant_params)
    if @applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      redirect_to '/applicants/new'
      # flash[:alert] = "Error: We will figure this out later"
    end
  end

  private

  def applicant_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end
