class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:applicant_id])
  end

  def new
  end

  def create
    @applicant = Applicant.create!(applicant_params)

    if applicant.save
      redirect_to("applicants/#{applicant.id}")
    else
      flash.now[:error] = "Could not create application!"
      render(      action: "new")
    end
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
