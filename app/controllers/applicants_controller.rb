class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
  end

  def create
    @applicant = Applicant.create(applicant_params)
    if @applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      redirect_to '/applicants/new'
      flash[:alert] = "Error: #{error_message(@applicant.errors)}"
    end
  end

  private

  def applicant_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode)
  end
end
