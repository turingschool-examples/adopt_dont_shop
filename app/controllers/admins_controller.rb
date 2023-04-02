class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.all
    @app_shelters = Shelter.open_apps
  end

  def application_show
    @application = Application.find(params[:id])
  end
end