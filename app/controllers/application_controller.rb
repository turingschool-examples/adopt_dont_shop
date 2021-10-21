class ApplicationController < ActionController::Base
  def welcome
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

  def show
    @application = Application.find(params[:id])
  end

  private
    params
end
