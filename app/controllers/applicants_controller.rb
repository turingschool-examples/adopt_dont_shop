class ApplicantsController < ApplicationController
  def show
    @search_pets = []
    @application = Applicant.find(params[:id])
    @added_pets = @application.associated_pets(params[:id])
    if params[:search].nil?

    else
      @search_pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    application = Applicant.new(applicant_params)
    if application.save
      redirect_to "/applicants/#{application.id}"
    else
      flash[:notice] = 'Application not created: Required information missing.'
      redirect_to '/applicants/new'
    end
  end

  def update
    application = Applicant.find(params[:id])
    pet = Pet.find(params[:pet_id])
    #add if else where we make sure we can find both objects before adding them in.
    application.pets << pet

    redirect_to "/applicants/#{application.id}"
  end

  def submit
    application = Applicant.find(params[:id])
    application.update(home_description: params[:home_description], status: 'Pending')

    redirect_to "/applicants/#{application.id}"
  end

  def applicant_params
    if params[:status].nil?
      params.permit(:name, :street_address, :city, :state, :zip_code, :home_description).merge(status: 'In Progress')
    else
      params.permit(:name, :street_address, :city, :state, :zip_code, :home_description)
    end
  end
end
