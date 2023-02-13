class AdminController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical
    @app_shelters = Shelter.pending_apps
  end
end