class AdminsController < ApplicationController

  def index
    @all_shelters = Shelter.all
    @app_shelters = Shelter.open_apps
  end
end