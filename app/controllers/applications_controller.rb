class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @applicant = @application.applicant
    require "pry"; binding.pry
  end

end
