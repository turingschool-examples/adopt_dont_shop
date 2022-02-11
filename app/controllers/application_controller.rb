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

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
