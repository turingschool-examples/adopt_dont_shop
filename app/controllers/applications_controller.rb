class ApplicationsController < ApplicationController
  def new
  end

  def create
    Application.create(application_params)
    redirect_to "applications/id"
  end
end