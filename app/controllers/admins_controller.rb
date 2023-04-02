class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.all
    @app_shelters = Shelter.open_apps
  end
end