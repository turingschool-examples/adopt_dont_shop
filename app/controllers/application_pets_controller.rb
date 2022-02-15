class ApplicationPetsController < ApplicationController

  def create
      application = Application.find(params[:application_id])
  end
end
