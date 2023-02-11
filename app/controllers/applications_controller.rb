class ApplicationsController < ApplicationController 

   def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    
    if !params[:searched_name].nil?
      search_result = @application.search_for_pet(params[:searched_name])
      if search_result != "Pet name not in system"
        @display_result = search_result.name
      else 
        @display_result = search_result
      end
    end
  end

  def new 
    @new_app = Application.new
  end

  def create 
    @new_app = Application.create(application_attributes)
    redirect_to "/applications/#{@new_app.id}"
  end

  def update 
    
    @application = Application.find(params[:id])
    @application.update(submission_update_attributes)
    # create a new PetApplication, with the pet id and application id. 
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_attributes 
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end

  def submission_update_attributes 
    params.permit(:description, :status)
  end

end