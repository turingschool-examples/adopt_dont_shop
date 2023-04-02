class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.reverse_alph
    @app_shelters = Shelter.open_apps
  end
end