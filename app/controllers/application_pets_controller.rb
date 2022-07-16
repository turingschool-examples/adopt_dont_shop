class ApplicationPetsController < ApplicationController
  def index
    @application = Application.find(params[:application_id])
  end
end
