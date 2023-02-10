class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zip_code}"
  end
end