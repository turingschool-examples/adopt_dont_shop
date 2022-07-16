class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_order
    @shelters_pending = Shelter.pending_apps
  end
end