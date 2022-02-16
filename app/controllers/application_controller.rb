class ApplicationController < ActionController::Base
  def welcome
    @pets = Pet.all
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
