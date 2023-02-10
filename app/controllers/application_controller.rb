class ApplicationController < ActionController::Base
  def welcome
  end

  def index
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_names = @pets.select(:name)
  end

  def new
    
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
