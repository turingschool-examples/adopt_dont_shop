class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @application.approved?
  end
end