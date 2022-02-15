class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alph
    # @applications = Application.display_pending_apps
    @pending_shelters = Shelter.shelter_apps_pending
  end
end
