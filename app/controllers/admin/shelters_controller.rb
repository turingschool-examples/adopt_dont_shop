class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alph
    @pending_shelters = Shelter.shelter_apps_pending
  end
end
