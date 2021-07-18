class ApplicationsController < ActionController::Base
  def welcome
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.associated_pets(params[:id])
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
