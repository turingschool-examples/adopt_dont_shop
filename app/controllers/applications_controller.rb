class ApplicationsController < ApplicationController 

   def show
    @application = Application.find(params[:id])
    @pets = @application.pets
   end

  def new 
    @new_app = Application.new
  end

  def create 
    @new_app = Application.new(application_attributes)
      if @new_app.save
        redirect_to "/applications/#{@new_app.id}"
      else
        flash.now[:messages] = @new_app.errors.full_messages
        render :new
     end  
  end

  def application_attributes 
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end

end