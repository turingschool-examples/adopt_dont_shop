class ApplicationController < ActionController::Base

  protect_from_forgery prepend: true
  
  def welcome
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
