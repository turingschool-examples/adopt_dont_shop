class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.sort_reverse_alphabetical
    @with_pending_apps = Shelter.with_pending_apps
  end

end