class ApplicantsController < ApplicationController
  def index
    @applicant = Applicant.all
  end

  def show
    @applicant = Applicant.find(params[:id])
    @applied_pets = @applicant.pets.all
    @pets = Pet.search(params[:search]) if params[:search]
  end

  def new
    @applicant = Applicant.new
  end

  def create
    applicant = Applicant.new(app_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to '/applicants/new'
      flash[:alert] = 'Error, all fields must be completed'
    end
  end

  def update
    applicant = Applicant.find(params[:id])
    if params[:pet]
      pet = Pet.find(params[:pet])
      applicant.adopt(pet)
      redirect_to "/applicants/#{applicant.id}"
    elsif params[:commit] == 'Submit Application'
      applicant.Pending!
      redirect_to "/applicants/#{applicant.id}"
    end
  end

  def app_params
    params.require(:applicant).permit(:name, :address_line_1, :city, :state, :zipcode, :description, :status)
  end
end
