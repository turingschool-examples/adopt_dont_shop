class ApplicantsController < ApplicationController
  def show
    if params[:search]
      @applicant = Applicant.find(params[:id])
      @pets = Pet.search(params[:search])
    else
      @applicant = Applicant.find(params[:id])
    end
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

  def update
    @applicant = Applicant.find(params[:id])
    @applicant.update({
      description: params[:description],
      status: "Pending"
      })
    flash[:notice] = "Your application is now pending"
    redirect_to "/applicants/#{@applicant.id}"
  end

  private
  def search_params
    params.permit[:search]
  end
  def applicant_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode, :status)
  end
end
