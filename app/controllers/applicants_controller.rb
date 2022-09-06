class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      flash.alert = @applicant.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    applicant = Applicant.find(params[:id])

    if params[:pet_id] != nil
      pet = Pet.find(params[:pet_id])
      applicant.pets << pet
    elsif params[:status] != nil
      applicant.update(applicant_params)
    end

    redirect_to "/applicants/#{applicant.id}"
  end

  def admin_show
    @applicant = Applicant.find(params[:id])
    @app = ApplicantPet
  end

  def admin_update
    @applicant = Applicant.find(params[:id])
    approval = ApplicantPet.app_status(params[:id], params[:pet_id])
    approval.update(admin_params)
    
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  private

  def applicant_params
    params.permit(:first_name, :last_name, :street_address, :city, :state, :zip, :status, :description)
  end

  def admin_params
    params.permit(:approved)
  end
end
