class ApplicantsController < ApplicationController
 
  def show 
    @applicant = Applicant.find(params[:id])
    if params[:pet_name]
      @pets = Pet.search(params[:pet_name])
    elsif params[:pet_id]
      pet = Pet.where(id: params[:pet_id])
      @applicant.pets << pet
      @pets = []
      redirect_to applicant_show_url
    else
      @pets =[]
    end
  end
  
  def update 
    applicant = Applicant.find(params[:id])
    applicant.update(description: params[:description], application_status: 'Pending')
    redirect_to "/applicants/#{applicant.id}"
  end

  def new
  end

  def create 
    applicant = Applicant.new(applicant_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
    flash[:alert] = "Error: #{error_message(applicant.errors)}"
      redirect_to '/applicants/new'
    end
  end

  private 
  def applicant_params 
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end