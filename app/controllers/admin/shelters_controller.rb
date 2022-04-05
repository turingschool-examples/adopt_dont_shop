class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha_names
    @pending = Shelter.pending_apps
  end
end
