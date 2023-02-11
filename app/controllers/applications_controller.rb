class ApplicationsController < ActionController::Base
  def welcome
  end

  def show
    @applicant = Application.find(params[:id])
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
