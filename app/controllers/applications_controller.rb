class ApplicationsController < ApplicationController 

   def show
    @application = Application.find(params[:id])
    @pets = @application.pets
   end

  def new 
    @new_app = Application.new
  end

  def create 
    @new_app = Application.create(application_attributes)
      # if @new_app.status.nil? 
      #   @new_app.status = "In Progress"
      #   @new_app.save
      # end # otherwise, it saved without a status..
    redirect_to "/applications/#{@new_app.id}"
  end

  def application_attributes 
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end

end