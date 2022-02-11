class ApplicationController < ActionController::Base
  def welcome
  end

  def show 
    @application = Application.find(params[:id])
    @pets = @application.pets.all
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zipcode}"
  end

  def new 
  end 

  def create
      applicant = Application.create!(applicant_params)
      redirect_to "/application/#{applicant.id}"
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
