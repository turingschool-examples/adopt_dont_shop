class ApplicationsController < ApplicationController
 def index
   @applications = Application.all
 end

 def new
   @application = Application.new
 end

 def create
   @application = Application.create!(application_params)
   redirect_to "/applications/#{@application.id}"
 end

 def show
      @application = Application.find(params[:id])
      if params[:search].present?
        @application = Application.find(params[:id])
        @pets = Pet.search(params[:pet_search])
      end
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
