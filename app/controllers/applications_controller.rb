class ApplicationsController < ApplicationController
  def show
    @application = Applications.find(params[:application_id])
  end
end
