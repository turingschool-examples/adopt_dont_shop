class ApplicationsController < ApplicationController 

   def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    
    if !params[:searched_name].nil?
      search_result = @application.search_for_pet(params[:searched_name])
      if search_result != "Pet name not in system"
        @display_result = search_result
      else 
        @display_result = search_result
      end
    end
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