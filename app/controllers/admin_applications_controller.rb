class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @application.check_approval!
  end
end
