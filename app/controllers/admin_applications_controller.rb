class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  private
  def application_params
    params.permit(:first, :last, :street, :city, :state, :zip, :description, :status, :pet_id)
  end

  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end