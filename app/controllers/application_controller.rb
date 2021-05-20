class ApplicationController < ActionController::Base
  def welcome
  end

  def new 
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
