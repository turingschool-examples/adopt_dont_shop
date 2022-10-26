class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    pending_applications = Application.pending_apps
    @shelters_pending = Shelter.find_shelters_from_apps(pending_applications)
  end
end