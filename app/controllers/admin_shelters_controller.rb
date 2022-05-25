class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.all.reverse_alpha_order
    @pending_apps = Shelter.pending_apps
  end
end
