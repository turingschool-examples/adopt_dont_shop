class ApplicationController < ActionController::Base
  def welcome
  end

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets.all
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zipcode}"
  end

  def new 
    @application = Application.new
  end 

  def create
    @application = Application.new(applicant_params)
    if @application.save
      redirect_to "/application/#{@application.id}"
    else 
      render :new
    end 
  end 

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

private
  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description)
  end
end
