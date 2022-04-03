class ApplicationController < ActionController::Base
  def welcome
  end

  def find_pet
    @pet = Pet.find(params[:id])
  end


  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
