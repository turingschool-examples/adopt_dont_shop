class ApplicationsController < ApplicationController
 def index
   @applications = Application.all
 end

 def new
   @application = Application.new
 end

 def create
   @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
 end

 def show
   @application = Application.find(params[:id])
   @pets = Pet.search(params[:search]) if params[:search].present?
 end

 def update
   @application = Application.find(params[:id])
    if params[:applicant_bio].present?
      @application.save
     @application.update!(applicant_bio: params[:applicant_bio], application_status: 'Pending')
    end
  redirect_to("/applications/#{@application.id}")
 end

 private
  def application_params
    params.permit(
            :name,
            :street_address,
            :city, :state, :zip_code,
            :applicant_bio,
            :application_status)
  end
end
