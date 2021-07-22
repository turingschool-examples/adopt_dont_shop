class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.alphabetize_name
    @pending_apps = Shelter.applications_pending
  end
end
