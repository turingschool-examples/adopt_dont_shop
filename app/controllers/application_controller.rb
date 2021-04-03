class ApplicationController < ActionController::Base
  def welcome
  end

  def show
    
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
