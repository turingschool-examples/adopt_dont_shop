class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pets = @applicant.pets
    @searched_pets = Pet.search(params[:search_name]).adoptable if !params[:search_name].nil?
    @application.status = "Pending" if params[:submit_app] == "Submit Application"
  end

  def new
    @applicant = Applicant.new
  end

  def create
    applicant = Applicant.new(applicant_params)
     if applicant.save
      redirect_to "/applicants/#{applicant.id}"
     else 
      redirect_to "/applicants/new"
      flash[:alert] = "Error: #{error_message(applicant.errors)}"
     end
  end

  def update
    applicant = Applicant.find(params[:id])
    applicant.update({good_home: params[:good_home],
                      status: "Pending"})
    applicant.save
    redirect_to "/applicants/#{applicant.id}"
  end

  private
  def applicant_params
    params.permit(:id, :name, :street, :city, :state, :zip, :good_home, :search_name)  
  end
end
