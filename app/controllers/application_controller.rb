class ApplicationController < ActionController::Base
  def welcome
  end

  def show
    @application = Application.find(params[:id])
  end


  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
