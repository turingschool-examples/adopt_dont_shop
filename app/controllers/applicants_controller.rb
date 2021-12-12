class ApplicantsController < ApplicationController
  def new

  end

  def create
    applicant = Applicant.new(applicant_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      redirect_to "/applicants/new"
      flash[:notice] = "Application not created: #{error_message(applicant.errors)}."
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    if params[:search]
      @pets = Pet.by_name(params[:search])
    else
      @pets = []
    end

    if params[:selected_pet_id]
      pet_applicant = PetApplicant.new({
        applicant_id: @applicant.id,
        pet_id: params[:selected_pet_id]
        })
        pet_applicant.save
    end

    if params[:description]
      @applicant.update({description: params[:description]})
      @applicant.save
    end
    @applicant.update_status
    @selected_pets = @applicant.pets
  end

  private

  def applicant_params
    params.permit(:id, :name, :address, :city, :state, :zip, :description)
  end
end
